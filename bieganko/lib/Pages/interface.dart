import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:test2/Pages/profile.dart';
import 'package:test2/Pages/settings.dart';
import 'package:test2/Pages/count_down_timer_page.dart';
import 'package:test2/Pages/landing.dart';
import 'package:test2/Pages/wybor.dart';
import 'package:test2/Pages/wykresy.dart';
import 'package:test2/main.dart';
import "dart:async";

String poziomm = "";

void main() {
  runApp(MyApp());
}

bool isSwitched = false;
int ukonczono = 0;
int ukonczonod1 = 0;
int ukonczonod2 = 0;
int ukonczonod3 = 0;
int tydzien = 0; // zmienna odpowiadajaca za wybrany tydzien - do bazy
int dzien = 0; // zmienna odpowiadajaca za wybrany dzien - do bazy
var poziom = 0;
var db = Mysql();

String pozioms = pztr(logowanie_poziom);
var cykle = 0; // zmienna przechowujaca cykle z bazy
var bieganie = 0; // zmienna przechowujaca czas biegu z bazy
var trucht = 0; // zmienna przechowujaca czas truchtu z bazy
var przebiezki = 0; // zmienna przechowujaca czas przebiezek z bazy

List<double> elevationList = <double>[]; // lista przechowujaca wysokosci

List<double> latitudeList =
    <double>[]; // lista przechowujaca szerkosc geograficzna
List<double> longitudeList =
    <double>[]; // lista przechowujaca dlugosc geograficzna
var zakres_x; // zmienna przechowuje zakres osi X na wykresie wysokosci
String user = "";

void setUserName(userName) {
  user = userName;
}

void updateProgress(userName, tydzien, dzien, ukonczono) {
  db.getConnection().then((conn) {
    String sql =
        'insert into heroku_9a6378669589f80.user_progress (email,tydzien,dzien,ukonczono) value ("$userName","$tydzien","$dzien","$ukonczono");';
    conn.query(sql);
    conn.close();
  });
}
  double meters=0.0; 
void get_meters()
{

   db.getConnection().then((conn) {
          String sql =
              "select metr from heroku_9a6378669589f80.meters where id_u=$logowanie_id and tydzien=$tydzien and dzien=$dzien";
          conn.query(sql).then((results) 
          {
            for (var row in results) {
                meters = row[0];
            }
          });
        });
}

void checkUkonczonoDzien(mode, user, tydzien, dzien) {
  switch (mode) {
    case 1:
      db.getConnection().then((conn) {
        String sql =
            "select ukonczono from heroku_9a6378669589f80.user_progress where dzien=$dzien and tydzien=$tydzien and email='$user'";
        conn.query(sql).then((results) {
          for (var row in results) {
            ukonczonod1 = row[0];
          }
        });
        conn.close();
      });

      print("KONIEC");
      print(ukonczonod1);
      break;
    case 2:
      db.getConnection().then((conn) {
        String sql =
            "select ukonczono from heroku_9a6378669589f80.user_progress where dzien=$dzien and tydzien=$tydzien and email='$user'";
        conn.query(sql).then((results) {
          for (var row in results) {
            ukonczonod2 = row[0];
          }
        });
        conn.close();
      });

      break;
    case 3:
      db.getConnection().then((conn) {
        String sql =
            "select ukonczono from heroku_9a6378669589f80.user_progress where dzien=$dzien and tydzien=$tydzien and email='$user'";
        conn.query(sql).then((results) {
          for (var row in results) {
            ukonczonod3 = row[0];
          }
        });
        conn.close();
      });

      break;
    default:
  }
}

void get_elevation(List elevationList) {
  // pobieranie wysokosci z bazy i dodawanie do listy
  // funkcja
  db.getConnection().then((conn) {
    String sql =
        "SELECT elevation FROM heroku_9a6378669589f80.markers where dzien=$dzien and tydzien=$tydzien and id_u=$logowanie_id;";
    conn.query(sql).then((results) {
      var cnt = 0;
      for (var row in results) {
        print("elevation day: $dzien");
        print("elevation week: $tydzien");
        print("elevation id: $logowanie_id");
        elevationList.add(row[0].toDouble());

        print("elevation: $elevationList");
        print("elevation cnt: $cnt");
        cnt += 1;
      }
    });
    conn.close();
  });
}

void getLatitudeLogitude(List latList, List longList) {
  db.getConnection().then((conn) {
    String sql =
        "SELECT latitude,longitude FROM heroku_9a6378669589f80.markers where dzien=$dzien and tydzien=$tydzien and id_u=$logowanie_id;";
    conn.query(sql).then((results) {
      var cnt = 0;
      for (var row in results) {
        print("latlong day: $dzien");
        print("latlong week: $tydzien");
        print("latlong id: $logowanie_id");
        latList.add(row[0]);
        longList.add(row[1]);
        print("latlong: latitude $latList");
        print("latlong: longitude $longList");
        print("latlong cnt: $cnt");
        cnt += 1;
      }
    });
    conn.close();
  });
}

void setWartosci(int tydzien, int dzien) {
  // pobranie wartosci biegu, cykli, truchtu z bazy danych
  db.getConnection().then((conn) {
    String sql =
        "select cykle,bieg,marsz from heroku_9a6378669589f80.sredni where dzien=$dzien and tydzien=$tydzien";
    conn.query(sql).then((results) {
      for (var row in results) {
        cykle = row[0];
        bieganie = row[1];
        trucht = row[2];
      }
    });
    conn.close();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

void daneztabeli(dzien, tydzien,
    pozioms) // wypisanie z bazy danych cyklu, biegu oraz marszu w zależności od poziomu
{
  if (logowanie_poziom == 1) {
    db.getConnection().then((conn) {
      String sql =
          "select cykle,bieg,marsz from heroku_9a6378669589f80.latwy where tydzien='$tydzien' and dzien='$dzien'";
      conn.query(sql).then((results) {
        for (var row in results) {
          cykle = row[0];
          bieganie = row[1];
          trucht = row[2];
        }
      });
      conn.close(); //tu moze byc jest za dużo nawiasów
    });
    print(cykle);
    print(bieganie);
    print(trucht);
    print(pozioms);
  }
  if (logowanie_poziom == 2) {
    db.getConnection().then((conn) {
      String sql =
          "select cykle,bieg,marsz from heroku_9a6378669589f80.sredni where tydzien='$tydzien' and dzien='$dzien'";
      conn.query(sql).then((results) {
        for (var row in results) {
          cykle = row[0];
          bieganie = row[1];
          trucht = row[2];
        }
      });
      conn.close(); //tu moze byc jest za dużo nawiasów
    });
    print(cykle);
    print(bieganie);
    print(trucht);
    print(pozioms);
  }
  if (logowanie_poziom == 3) {
    db.getConnection().then((conn) {
      String sql =
          "select cykle,bieg,marsz from heroku_9a6378669589f80.trudny where tydzien='$tydzien' and dzien='$dzien'";
      conn.query(sql).then((results) {
        for (var row in results) {
          cykle = row[0];
          bieganie = row[1];
          trucht = row[2];
        }
      });
      conn.close(); //tu moze byc jest za dużo nawiasów
    });
    print(cykle);
    print(bieganie);
    print(trucht);
    print(pozioms);
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Profile(),
      )); // Funkcja do dodawania opcji do klikniecia guziczka w drawerze
      break; // za każdym razem jak chcecie coś dodać do przycisku to dodajcie case
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Settings(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
      break;
  }
}

class headpage extends StatefulWidget {
  @override
  _headpageState createState() => _headpageState();
}

class _headpageState extends State<headpage> {
  List<ElevatedButton> funTygodnie() {
    //funkcja zwracajaca liste elevetedbutton
    List<ElevatedButton> listaTygodni = []; //inicjalizacja pustej listy tygodni
    int x; //zmienna okreslajaca zajkres tworzenia ilosci kafelkow tygodni
    if (logowanie_poziom == 1) {
      //sprawdzanie kolejnych warunkow jaki poziom zostal wybrany i ustawianie zmiennej x ktora jest w for
      x = 16;
    } else if (logowanie_poziom == 2) {
      x = 10;
    } else {
      x = 8;
    }
    for (int i = 0; i < x; i++) {
      //tworzenie x ElevetedButton (x to zmienna zalezna od wybranego poziomu trudnosci)
      var newButton = ElevatedButton(
          onPressed: () async {
            print("Wybrałeś tydzien $i");
            tydzien = i + 1;
            ukonczonod1 = 0;
            ukonczonod2 = 0;
            ukonczonod3 = 0;
            checkUkonczonoDzien(1, user, tydzien, 1);
            checkUkonczonoDzien(2, user, tydzien, 2);
            checkUkonczonoDzien(3, user, tydzien, 3);
            await new Future.delayed(const Duration(milliseconds: 500));

            print("TYDZIEN");
            print("D1");
            print(ukonczonod1);
            print("D2");
            print(ukonczonod2);

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Strona3()));
          },
          child: Text(
            'Tydzień ${i + 1}',
            style: TextStyle(fontSize: 25),
          ),
          style: ElevatedButton.styleFrom(
              primary:
                  getcolor()) //ustawienie koloru kafelka tygodnia w zaleznosci od wybranego poziomu trudnosci

          );
      listaTygodni.add(newButton);
    }
    return listaTygodni; //zwrocenie calej listy kafelkow przez funkcje
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
              color: Colors.black,
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 30,
                      child: Text('Witaj $logowanie_imie',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  new Container(
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          AdaptiveTheme.of(context).toggleThemeMode();
                        });
                      },
                      activeColor: Colors.green,
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Colors.red,
                      inactiveTrackColor: Colors.white,
                    ),
                  ),
                  new Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Motyw',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DrawerHeader(
                    child: Container(
                      height: 70,
                      alignment: Alignment.centerLeft,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: new NetworkImage(
                            "https://previews.123rf.com/images/tuktukdesign/tuktukdesign1712/tuktukdesign171200009/91432863-benutzer-ikonen-vektor-m%C3%A4nnlicher-personen-symbol-profil-avatara-unterzeichnen-herein-flache-farbgly.jpg",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'Profil',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context,
                        0), //wywołanie funkcji z indexem 0(wartosci case)
                  ),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'Ustawienia',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 250),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                      text: 'Wyloguj',
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 2)),
                  Divider(color: Colors.white70),
                ],
              )),
        ),
        appBar: AppBar(
          title: Text('Bieganko'),
          backgroundColor: getcolor(),
        ),
        body: GridView.count(
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            children: funTygodnie()));
  }
}

class Strona3 extends StatefulWidget {
  @override
  State<Strona3> createState() => _Strona3();
}

class _Strona3 extends State<Strona3> {
  List<ElevatedButton> fun_Dni_Tygodnia() {
    //funkcja zwracajaca liste elevetedbutton
    List<ElevatedButton> listaDniTygodnia =
        []; //inicjalizacja listy elevetedbutton
    for (int i = 0; i < 3; i++) {
      //petla do 3 bo potrzebujemy tylko pon/sr i sobote
      if (i == 0) {
        //sprawdzanie kolejnych i tak aby zmienic napisy w elevetedbutton na pon, sr lub sob
        var newButton;
        if (ukonczonod1 == 0) {
          newButton = ElevatedButton(
            onPressed: () async {
              print("Wybrałeś poniedziałek");
              dzien = i + 1;
              setWartosci(tydzien, dzien);
              print("tydzien: $tydzien");
              print("dzien: $dzien");
              daneztabeli(dzien, tydzien, pozioms);
              //setWartosci(tydzien, dzien);
              await new Future.delayed(const Duration(milliseconds: 500));
              setrunTime(bieganie);
              setbreakTime(trucht);
              setCycle(cykle);
              getUserInfo(user, tydzien, dzien);
              print(
                  "Wartosci Poniedzialek dla dnia: $dzien i tygodnia $tydzien: \nCykle: $cykle\n Bieg: $bieganie\n Trucht: $trucht\n");
              bieganie = 0;
              trucht = 0;
              cykle = 0;
              CountDownTimerPage.navigatorPush(
                  context); // przejscie do strony z timerem
            },
            child: const Text(
              'Poniedziałek',
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
                primary: getcolor(),
                fixedSize: Size(300,
                    80)), //ustawienie koloru kafelka w zaleznosci jaki poziom trudnosci wybral uzytkownik
          );
        } //else {
        //   newButton = ElevatedButton(
        //     onPressed: null,
        //     child: const Text('Poniedziałek', style: TextStyle(fontSize: 30)),
        //     style: ElevatedButton.styleFrom(
        //         primary: getcolor(), fixedSize: Size(300, 80)),
        //   );
        else {
          newButton = ElevatedButton(
            onPressed: () async {
              dzien = i + 1;
              daneztabeli(dzien, tydzien, pozioms);
              await new Future.delayed(const Duration(milliseconds: 500));
              zakres_x = cykle * (bieganie + trucht);
              print('Tydzien w podumowsaniu $tydzien');
              print('Dzien w podumowsaniu $dzien');
              print('Poziom w podumowsaniu $pozioms');
              print('cykle w podumowsaniu $cykle');
              print('bieganie w podumowsaniu $bieganie');
              print('trucht w podumowsaniu $trucht');
              print('zakres x w podumowsaniu $zakres_x');
              get_elevation(elevationList); // tutaj pobieramy wartosci z bazy
              await new Future.delayed(
                  const Duration(milliseconds: 500)); // czekamy na pobranie
              getLatitudeLogitude(latitudeList, longitudeList);
              await new Future.delayed(
                  const Duration(milliseconds: 500)); // czekamy na pobranie

              set_wysokosci(
                  elevationList); // ustawiamy liste w stronie wykresy tak aby w niej mozna bylo korzystac
              setLatLong(latitudeList, longitudeList);
              elevationList.clear();
              latitudeList.clear();
              longitudeList.clear(); // czyszcze liste
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WykresWysokosci()));
            },
            child: const Text(
              'Podsumowanie\nPoniedziałek',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue, fixedSize: Size(300, 80)),
          );
        }
        listaDniTygodnia.add(newButton); //dodanie przycisku do listy przyciskow
      } else if (i == 1) {
        var newButton;
        if (ukonczonod2 == 0) {
          newButton = ElevatedButton(
            onPressed: () async {
              print("Wybrałeś Środa");
              dzien = i + 1;
              //setWartosci(tydzien, dzien);
              daneztabeli(dzien, tydzien, pozioms);
              await new Future.delayed(const Duration(milliseconds: 500));
              setrunTime(bieganie);
              setbreakTime(trucht);
              setCycle(cykle);
              getUserInfo(user, tydzien, dzien);
              print(
                  "Wartosci Środa dla dnia: $dzien i tygodnia $tydzien: \nCykle: $cykle\n Bieg: $bieganie\n Trucht: $trucht\n");
              bieganie = 0;
              trucht = 0;
              cykle = 0;
              CountDownTimerPage.navigatorPush(context);
            },
            child: const Text(
              'Środa',
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
                primary: getcolor(), fixedSize: Size(300, 80)),
          );
        } //else {
        //   newButton = ElevatedButton(
        //     onPressed: null,
        //     child: const Text('Środa', style: TextStyle(fontSize: 30)),
        //     style: ElevatedButton.styleFrom(
        //         primary: getcolor(), fixedSize: Size(300, 80)),
        //   );
        // }
        else {
          newButton = ElevatedButton(
            onPressed: () async {
              dzien = i + 1;
              daneztabeli(dzien, tydzien, pozioms);
              await new Future.delayed(const Duration(milliseconds: 500));
              zakres_x = cykle * (bieganie + trucht);
              print('Tydzien w podumowsaniu $tydzien');
              print('Dzien w podumowsaniu $dzien');
              print('Poziom w podumowsaniu $pozioms');
              print('cykle w podumowsaniu $cykle');
              print('bieganie w podumowsaniu $bieganie');
              print('trucht w podumowsaniu $trucht');
              print('zakres x w podumowsaniu $zakres_x');

              get_elevation(elevationList); // tutaj pobieramy wartosci z bazy
              await new Future.delayed(
                  const Duration(milliseconds: 500)); // czekamy na pobranie
              getLatitudeLogitude(latitudeList, longitudeList);
              await new Future.delayed(
                  const Duration(milliseconds: 500)); // czekamy na pobranie

              set_wysokosci(
                  elevationList); // ustawiamy liste w stronie wykresy tak aby w niej mozna bylo korzystac
              setLatLong(latitudeList, longitudeList);
              elevationList.clear();
              latitudeList.clear();
              longitudeList.clear(); // czyszcze liste
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WykresWysokosci()));
            },

            // () {
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => WykresWysokosci()));
            // },
            child: const Text(
              'Podsumowanie\nŚroda',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue, fixedSize: Size(300, 80)),
          );
        }
        listaDniTygodnia.add(newButton);
      } else {
        var newButton;
        if (ukonczonod3 == 0) {
          newButton = ElevatedButton(
            onPressed: () async {
              print("Wybrałeś Sobota");
              dzien = i + 1;
              daneztabeli(dzien, tydzien, pozioms);
              //setWartosci(tydzien, dzien);
              await new Future.delayed(const Duration(milliseconds: 500));
              setrunTime(bieganie);
              setbreakTime(trucht);
              setCycle(cykle);
              getUserInfo(user, tydzien, dzien);
              print(
                  "Wartosci Sobota dla dnia: $dzien i tygodnia $tydzien: \nCykle: $cykle\n Bieg: $bieganie\n Trucht: $trucht\n");
              bieganie = 0;
              trucht = 0;
              cykle = 0;
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => CountDownTimerPage()),
              //     (route) => false); // przejscie do strony z timerem
              CountDownTimerPage.navigatorPush(
                  context); // przejscie do strony z timerem
            },
            child: const Text(
              'Sobota',
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
                primary: getcolor(), fixedSize: Size(300, 80)),
          );
        } //else {
        //   newButton = ElevatedButton(
        //     onPressed: null,
        //     child: const Text('Sobota',
        //         style: TextStyle(
        //             fontSize:
        //                 30)), //ustawienie koloru kafelka w zaleznosci jaki poziom trudnosci wybral uzytkownik
        //     style: ElevatedButton.styleFrom(
        //         primary: getcolor(), fixedSize: Size(300, 80)),
        //   );
        // }
        else {
          newButton = ElevatedButton(
            onPressed: () async {
              dzien = i + 1;
              daneztabeli(dzien, tydzien, pozioms);
              await new Future.delayed(const Duration(milliseconds: 500));
              zakres_x = cykle * (bieganie + trucht);
              print('Tydzien w podumowsaniu $tydzien');
              print('Dzien w podumowsaniu $dzien');
              print('Poziom w podumowsaniu $pozioms');
              print('cykle w podumowsaniu $cykle');
              print('bieganie w podumowsaniu $bieganie');
              print('trucht w podumowsaniu $trucht');
              print('zakres x w podumowsaniu $zakres_x');

              get_elevation(elevationList); // tutaj pobieramy wartosci z bazy
              await new Future.delayed(
                  const Duration(milliseconds: 500)); // czekamy na pobranie
              getLatitudeLogitude(latitudeList, longitudeList);
              await new Future.delayed(
                  const Duration(milliseconds: 500)); // czekamy na pobranie
              get_meters();
              await new Future.delayed(
                  const Duration(milliseconds: 500));
              print("meters: $meters  $tydzien $dzien $logowanie_id");
              set_wysokosci(
                  elevationList); // ustawiamy liste w stronie wykresy tak aby w niej mozna bylo korzystac
              setLatLong(latitudeList, longitudeList);
              elevationList.clear();
              latitudeList.clear();
              longitudeList.clear(); // czyszcze liste

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WykresWysokosci()));
            },
            // () {
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => WykresWysokosci()));
            // },
            child: const Text(
              'Podsumowanie\nSobota',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue, fixedSize: Size(300, 80)),
          );
        }
        listaDniTygodnia.add(newButton);
      }
    }
    return listaDniTygodnia; //zwrocenie calej listy kafelkow przez funkcje
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dni tygodnia'),
          backgroundColor: getcolor(),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: 10,
              height: 30,
            ),
            ...fun_Dni_Tygodnia(),
            SizedBox(
              width: 10,
              height: 30,
            ),
          ]),
        ]));
  }
}
