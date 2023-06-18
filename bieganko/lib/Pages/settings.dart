import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:test2/Pages/interface.dart';
import 'package:test2/Pages/wybor.dart';
import 'package:test2/main.dart';
import 'package:test2/Pages/landing.dart';
import 'package:test2/Pages/count_down_timer_page.dart';

void main() {
  runApp(MyApp());
}

var haslo1;
var haslo2;
var email1;
var email2;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ustawienia',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            AnimatedButton(
              child: Text(
                'Zmien poziom trudnosci',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => change()));
              },
            ),
            SizedBox(
              height: 5,
            ),
            AnimatedButton(
              child: Text(
                'Zmień hasło',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => password()));
              },
            ),
            SizedBox(
              height: 5,
            ),
            AnimatedButton(
              child: Text(
                'Zmień e-mail',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => email()));
              },
            ),
            SizedBox(
              height: 5,
            ),
           AnimatedButton(
              child: Text(
                'Wstecz',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new Container(
              child: Text(
                  'Zmiana trybu(minuty, sekundy)',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
            ),
            new Container(
              
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    setMinutes(value);
                    print(value);
                  });
                },
                activeColor: Colors.green,
                activeTrackColor: Colors.white,
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Klasa do zmiany poziomu trudnosci skopiowana z wybor.dart
var db = Mysql();

class change extends StatefulWidget {
  @override
  _change createState() => _change();
}

class _change extends State<change> {
  @override
  Widget build(BuildContext context) {
    void dodaj_uzytkownika(int trudnosc) {
      db.getConnection().then((conn) {
        String sql =
            'update heroku_9a6378669589f80.logowanie set poziom_tr=$trudnosc where email="$logowanie_mail"';

        conn.query(sql);
      });
      db.getConnection().then((conn) {
        String sql =
            'update heroku_9a6378669589f80.user_progress set ukonczono=0 where email="$logowanie_mail"';

        conn.query(sql);
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.green,
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Wybierz swój poziom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      color: Colors.green,
                      child: Text(
                        'Łatwy',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        LvlOfDifficulty = 1;
                        dodaj_uzytkownika(LvlOfDifficulty);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      color: Colors.yellow.shade900,
                      child: Text(
                        'Średni',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        LvlOfDifficulty = 2;
                        dodaj_uzytkownika(LvlOfDifficulty);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      color: Colors.red,
                      child: Text(
                        'Trudny',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        LvlOfDifficulty = 3;
                        dodaj_uzytkownika(LvlOfDifficulty);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//koniec klasy do zmiany poziomu trudnosci

//Klasa do zmiany hasla
class password extends StatefulWidget {
  @override
  _password createState() => _password();
}

class _password extends State<password> {
  var komunikat;
  bool vis2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.green,
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    child: Text(
                      "$komunikat",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    visible: vis2),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    onChanged: (text5) {
                      haslo1 = text5;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    onChanged: (text6) {
                      haslo2 = text6;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Repeat Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                AnimatedButton(
                  child: Text(
                    'Zmien hasło',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    if (haslo1 == haslo2) {
                      db.getConnection().then((conn) {
                        String sql =
                            'update heroku_9a6378669589f80.logowanie set haslo="$haslo1" where email="$logowanie_mail"';

                        conn.query(sql);

                        ogloszenie = "Pomyślnie zmieniono hasło";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
                    } else {
                      vis2 = true;
                      setState(() {
                        komunikat = "Popraw hasło";
                      });
                    }
                  },
                ),
              ],
            )));
  }
}
//koniec klasy do zmiany hasla

//klasa do zmiany e-maila
class email extends StatefulWidget {
  @override
  _email createState() => _email();
}

class _email extends State<email> {
  var komunikat;
  bool vis2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.green,
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    child: Text(
                      "$komunikat",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    visible: vis2),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    onChanged: (text5) {
                      email1 = text5;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nowy e-mail',
                        hintText: 'Enter E-mail'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    onChanged: (text6) {
                      email2 = text6;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Powtórz nowy e-mail',
                        hintText: 'Enter E-mail'),
                  ),
                ),
                AnimatedButton(
                  child: Text(
                    'Zmien e-mail',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    if (email1 == email2) {
                      db.getConnection().then((conn) {
                        String sql =
                            'update heroku_9a6378669589f80.logowanie set email="$email1" where haslo="$logowanie_haslo" and  email="$logowanie_mail"';

                        conn.query(sql);

                        ogloszenie = "Pomyślnie zmieniono e-mail";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
                    } else {
                      vis2 = true;
                      setState(() {
                        komunikat = "Popraw e-mail";
                      });
                    }
                  },
                ),
              ],
            )));
  }
}
