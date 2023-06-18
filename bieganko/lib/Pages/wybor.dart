import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:test2/Pages/rejestracja.dart';
import 'package:test2/main.dart';
import 'package:test2/Pages/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

var db = Mysql();
int LvlOfDifficulty = 0;
//Funkcja zmiany koloru appbara wedlug poziomu trudnosci
Color getcolor() {
  if (logowanie_poziom == 1) {
    return Colors.green;
  } else if (logowanie_poziom == 2) {
    return Colors.yellow.shade900;
  } else if (LvlOfDifficulty == 3) {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

class wybor extends StatefulWidget {
  @override
  _wyborState createState() => _wyborState();
}

class _wyborState extends State<wybor> {
  @override
  Widget build(BuildContext context) {

    void dodaj_uzytkownika(int trudnosc) {
      if (mail == null || haslo == null || imie == null || nazwisko == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
            showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text('Błąd'),
          content: Text('Nie udało się dodać użytkownika do bazy danych.\nSprawdź porawność wpisanych danych i spróbuj ponownie'),
          actions: [
            TextButton(onPressed: ()=>Navigator.pop(context), child: Text('OK'))
          ],
        ));
      } else {
        db.getConnection().then((conn) {
          String sql =
              'insert into heroku_9a6378669589f80.logowanie (email,haslo,imie,nazwisko,poziom_tr) value ("$mail","$haslo","$imie","$nazwisko",$trudnosc);';
          conn.query(sql);
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text('Zarejestrowano pomyślnie'),
          content: Text('Twoje konto zostało zarejestrowane\nMożesz teraz się zalogować'),
          actions: [
            TextButton(onPressed: ()=>Navigator.pop(context), child: Text('OK'))
          ],
        ));
      }
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
