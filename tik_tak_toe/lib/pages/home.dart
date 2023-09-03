import 'package:flutter/material.dart';
import 'package:tik_tak_toe/widgets/mybutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlayerX = true;

  void changePlayer() {
    setState(() {
      isPlayerX = !isPlayerX;
    });
  }

  List<MyButton> lista = [];
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TikTakToe',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Text('data'),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return MyButton(
                  onTap: () {
                    changePlayer();
                  },
                  currentPlayer: isPlayerX,
                  index: index,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: isPlayerX
                ? const Text(
                    'Player X turn',
                    style: TextStyle(fontSize: 18),
                  )
                : const Text(
                    'Player O turn',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        ],
      ),
    );
  }
}
