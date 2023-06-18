import 'package:flutter/material.dart';
import 'package:test2/Pages/interface.dart';
import 'package:test2/Pages/rejestracja.dart';
import 'package:test2/Pages/wybor.dart';
import 'package:animated_button/animated_button.dart';
import 'dart:async';
import 'package:test2/main.dart';

bool vis = false;
var ogloszenie;
var db = Mysql();
var logowanie_mail;
var logowanie_haslo;
var logowanie_imie;
var logowanie_nazwisko;
var logowanie_poziom;
var logowanie_id;
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: wybor(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    void logowanie(var mail1, var haslo1) {

      db.getConnection().then((conn) {
        String sql =
            "select imie, nazwisko, poziom_tr,ID from heroku_9a6378669589f80.logowanie where email='$mail1' and haslo='$haslo1'";
        conn.query(sql).then((results) {
          for (var row in results) {
            setState(() {
              logowanie_imie = row[0];
              logowanie_nazwisko = row[1];
              logowanie_poziom = row[2];
              logowanie_id = row[3];
              if (logowanie_imie != null ||
                  logowanie_nazwisko != null ||
                  logowanie_poziom != null ||
                  logowanie_id != null) {
                setUserName(mail1);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => headpage()));
              }
            });
          }

        });
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        if (logowanie_imie == null ||
            logowanie_nazwisko == null ||
            logowanie_poziom == null ||
            logowanie_id == null) {

          showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Niepoprawne dane'),
              content: const Text('Sprawdź poprawność wpisanych danych i spróbuj ponownie'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'))
              ],
            ));
        }
      });
    }

    void zapytanie() {
      db.getConnection().then((conn) {
        String sql = "select cykle from heroku_9a6378669589f80.sredni";
        conn.query(sql).then((results) {
          for (var row in results) {
            print(row[0]);
          }
        });
      });
    }

    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.green,
          ],
      )),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('lib/Resources/zut.png')),
              ),
            ),
            SizedBox(
                height: 15,
                child: Visibility(
                    child: Text(
                      "$ogloszenie",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    visible: vis)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text4) {
                  logowanie_mail = text4;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text5) {
                  logowanie_haslo = text5;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            MaterialButton(
              onPressed: () {
                db.getConnection().then((conn) {
                  String sql =
                      "select imie, nazwisko, poziom_tr,ID from heroku_9a6378669589f80.logowanie where email='wojtek@wp.pl' and haslo='12345'";

                  conn.query(sql).then((results) {
                    for (var row in results) {
                      setState(() {
                        logowanie_imie = row[0];
                        logowanie_nazwisko = row[1];
                        logowanie_poziom = row[2];

                        logowanie_id = row[3];
                        if (logowanie_imie != null ||
                            logowanie_nazwisko != null ||
                            logowanie_poziom != null ||
                            logowanie_id != null) {
                          setUserName("wojtek@wp.pl");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => headpage()));
                        }
                      });
                    }
                  });
                });
                Future.delayed(const Duration(milliseconds: 10000), () {
                  if (logowanie_imie == null &&
                      logowanie_nazwisko == null &&
                      logowanie_poziom == null &&
                      logowanie_id == null) {
                    setState(() {
                      ogloszenie = "nieprawidlowy haslo lub mail";
                      vis = true;
                    });
                  }
                });

                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: AnimatedButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {


                  

                  logowanie(logowanie_mail, logowanie_haslo);
                },
              ),
            ),
            AnimatedButton(
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => rejestracja()));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
