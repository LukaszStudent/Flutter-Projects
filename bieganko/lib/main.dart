import 'package:flutter/material.dart';
import 'package:test2/Pages/landing.dart';
import 'package:mysql1/mysql1.dart';
import 'package:adaptive_theme/adaptive_theme.dart';


class Mysql {
  static String host = "eu-cdbr-west-02.cleardb.net",
      user = 'b6a96c5b53703c',
      password = 'd6e17b6e',
      db = "heroku_9a6378669589f80";
  static int port = 3306;
  Mysql();
  Future<MySqlConnection> getConnection() async {
    var setings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);

    return await MySqlConnection.connect(setings);
  }
}
// class Mysql {
//   static String host = "i54jns50s3z6gbjt.chr7pe7iynqr.eu-west-1.rds.amazonaws.com",
//       user = 'a211cbww5w630rr0',
//       password = 'w92mdxj7w7uc6z1b',
//       db = "m00i05yxpvdfi6fi";
//   static int port = 3306;
//   Mysql();
//   Future<MySqlConnection> getConnection() async {
//     var setings = new ConnectionSettings(
//         host: host, port: port, user: user, password: password, db: db);
//     return await MySqlConnection.connect(setings);
//   }
// }


void main() => runApp(MyApp());

ThemeData _lightTheme = ThemeData(
    //accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue);

ThemeData _darkTheme = ThemeData(
    //accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        //accentColor: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        //accentColor: Colors.amber,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pomodoro app',
        theme: darkTheme,
        darkTheme: darkTheme,
        home: LoginScreen(),
      ),
    );
  }
}
