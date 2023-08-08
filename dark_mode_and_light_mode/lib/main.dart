import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
      appBar: AppBar(
        title: const Text('Switches'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            letterSpacing: 5, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wybierz dzień lub noc'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.sunny),
                Switch(
                    value: isDark,
                    onChanged: (val) {
                      setState(() {
                        isDark=val;
                        //isDark!=isDark;
                      });
                    }),
                Icon(Icons.nightlight),
              ],
            )
          ],
        ),
      ),
    ),
      theme: isDark ? _darkMode : _lightMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

ThemeData _lightMode = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.light,
);

ThemeData _darkMode = ThemeData(
  primarySwatch: Colors.grey,
  brightness: Brightness.dark,
);

bool isDark = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switches'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            letterSpacing: 5, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wybierz dzień lub noc'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.sunny),
                Switch(
                    value: isDark,
                    onChanged: (val) {
                      setState(() {
                        isDark=val;
                        //isDark!=isDark;
                      });
                    }),
                Icon(Icons.nightlight),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isDark,
      onChanged: (val) {
        setState(() {
          isDark = val;
        });
      },
    );
  }
}
