import 'package:flutter/material.dart';

class PlayWords extends StatelessWidget {
  const PlayWords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: "playWordsHeroTag",
        child: Center(
          child: Image.network(
              "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"),
        ),
      ),
    );
  }
}
