import 'package:flutter/material.dart';
import 'package:test2/Pages/wybor.dart';
import 'package:animated_button/animated_button.dart';
import 'package:email_validator/email_validator.dart';

bool isValid_mail=true;
bool isValid_haslo=true;
void main() {
  runApp(MyApp());
}

void walidacja_maila(String mail, BuildContext context) {
  if (!EmailValidator.validate(mail)) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Niepoprawne adres email'),
              content: const Text('Sprawdź poprawność wpisanego adresu email'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'))
              ],
            ));
    isValid_mail=false;
  }
  else{
    isValid_mail=true;
  }
}

void walidacja_hasla(String haslo, BuildContext context) {
  if (haslo.length < 6) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Niepoprawne hasło'),
              content: const Text('Hasło powinno zawierać 6 znaków'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'))
              ],
            ));
    isValid_haslo=false;
  }
  else{
    isValid_haslo=true;
  }
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

class rejestracja extends StatefulWidget {
  @override
  _rejestracjaState createState() => _rejestracjaState();
}

var imie;
var nazwisko;
var mail;
var haslo;

class _rejestracjaState extends State<rejestracja> {
  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text) {
                  imie = text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter name'),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text1) {
                  nazwisko = text1;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'last name',
                    hintText: 'Enter last name'),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text2) {
                  mail = text2;
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
              child: TextField(
                onChanged: (text3) {
                  haslo = text3;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: AnimatedButton(
                child: Text(
                  'Zarejestruj',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  walidacja_maila(mail, context);
                  walidacja_hasla(haslo, context);
                  if (isValid_haslo && isValid_mail) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => wybor()));
                  }
                },
              ),
            ),
            SizedBox(height: 15),
            AnimatedButton(
              child: Text(
                'Wstecz',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
