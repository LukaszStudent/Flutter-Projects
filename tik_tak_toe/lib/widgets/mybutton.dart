import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tik_tak_toe/service/gamelogic.dart';

class MyButton extends StatefulWidget {
  final Function() onTap;
  final bool currentPlayer;
  final int index;
  final GameLogic gameLogic;
  const MyButton(
      {super.key,
      required this.onTap,
      required this.currentPlayer,
      required this.index,
      required this.gameLogic});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  dynamic icon = const Text('');
  void changePlayer() {
    if (widget.currentPlayer) {
      setState(() {
        icon = const FaIcon(
          FontAwesomeIcons.x,
          color: Colors.black,
        );
      });
    } else if (!widget.currentPlayer) {
      setState(() {
        icon = const Icon(
          Icons.circle_outlined,
          color: Colors.black,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (icon is Text && !widget.gameLogic.isEnd) {
          widget.onTap();
          changePlayer();
          if (widget.currentPlayer) {
            widget.gameLogic.indexesPlayerX.add(widget.index);
            widget.gameLogic.isEnd =
                widget.gameLogic.endGame(widget.gameLogic.indexesPlayerX);
          } else {
            widget.gameLogic.indexesPlayerO.add(widget.index);
            widget.gameLogic.isEnd =
                widget.gameLogic.endGame(widget.gameLogic.indexesPlayerO);
          }
        }

        if (widget.gameLogic.isEnd) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Center(
                  child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: widget.currentPlayer
                        ? Text('Player X win')
                        : Text('Player O defeat'),
                  ),
                  !widget.currentPlayer
                      ? Text('Player O defeat')
                      : Text('Player X win'),
                ],
              )),
            ),
          );
        }
      },
      child: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
