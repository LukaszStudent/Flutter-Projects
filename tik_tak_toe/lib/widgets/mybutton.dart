import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Function() onTap;
  final bool currentPlayer;
  final int index;
  const MyButton(
      {super.key,
      required this.onTap,
      required this.currentPlayer,
      required this.index});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isEnd = false;
  List<int> indexesPlayerX = [];
  List<int> indexesPlayerO = [];
  bool endGame(List coordinates) {
    if (coordinates.contains(0) &&
        coordinates.contains(1) &&
        coordinates.contains(2)) {
      //row 1
      return true;
    } else if (coordinates.contains(3) &&
        coordinates.contains(4) &&
        coordinates.contains(5)) {
      //row2
      return true;
    } else if (coordinates.contains(6) &&
        coordinates.contains(7) &&
        coordinates.contains(8)) {
      //row3
      return true;
    } else if (coordinates.contains(0) &&
        coordinates.contains(3) &&
        coordinates.contains(6)) {
      //col1
      return true;
    } else if (coordinates.contains(1) &&
        coordinates.contains(4) &&
        coordinates.contains(7)) {
      //col2
      return true;
    } else if (coordinates.contains(2) &&
        coordinates.contains(5) &&
        coordinates.contains(8)) {
      //col3
      return true;
    } else if (coordinates.contains(0) &&
        coordinates.contains(4) &&
        coordinates.contains(8)) {
      //cross1
      return true;
    } else if (coordinates.contains(2) &&
        coordinates.contains(4) &&
        coordinates.contains(6)) {
      //cross2
      return true;
    }
    return false;
  }

  dynamic icon = const Text('');
  void changePlayer() {
    if (widget.currentPlayer) {
      setState(() {
        icon = const Icon(Icons.ac_unit_outlined);
      });
    } else {
      setState(() {
        icon = const Icon(Icons.circle_outlined);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!isEnd) {
          widget.onTap();
          if (widget.currentPlayer) {
            indexesPlayerX.add(widget.index);
            print('Player X = ${indexesPlayerX.length}');
            isEnd = endGame(indexesPlayerX);
          } else {
            indexesPlayerO.add(widget.index);
            print('Player 0 = ${indexesPlayerO}');
            isEnd = endGame(indexesPlayerO);
          }
          changePlayer();
        } else {
          print('koniec');
        }
      },
      child: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
