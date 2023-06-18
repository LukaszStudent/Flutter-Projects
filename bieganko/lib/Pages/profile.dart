import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test2/Pages/landing.dart';

var poziomm;
String pztr(var poziom) {
  if (poziom == 1) {
    poziomm = "latwy";
  }
  if (poziom == 2) {
    poziomm = "sredni";
  }
  if (poziom == 3) {
    poziomm = "trudny";
  }
  return poziomm;
}

final picker = ImagePicker();

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

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

PickedFile? imageFile = null;

class _ProfileState extends State<Profile> {
  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

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
                new Container(
                    child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'https://previews.123rf.com/images/tuktukdesign/tuktukdesign1712/tuktukdesign171200009/91432863-benutzer-ikonen-vektor-m%C3%A4nnlicher-personen-symbol-profil-avatara-unterzeichnen-herein-flache-farbgly.jpg'),
                  radius: 80.0,
                  child: new Container(
                    padding: const EdgeInsets.all(0.0),
                  ),
                )),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Imie: $logowanie_imie\n Nazwisko: $logowanie_nazwisko\nEmail: $logowanie_mail \n Poziom trudności: ' +
                      pztr(logowanie_poziom) +
                      '\nPrzebieg: 0',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            AnimatedButton(
              color: Colors.green,
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
            AnimatedButton(
              color: Colors.green,
              child: Text(
                'Zrób zdjęcie',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                _openCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
