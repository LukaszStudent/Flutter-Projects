import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen_provider.dart';

class CustomButton extends StatelessWidget {
  final Function()? function;
  final String buttonValue;
  final Color? txtColor;
  final Color? bgColor;
  const CustomButton(
      {super.key,
      required this.buttonValue,
      this.bgColor = const Color.fromRGBO(66, 66, 66, 1),
      this.function,
      this.txtColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (bgColor == const Color.fromRGBO(66, 66, 66, 1)) {
          Provider.of<ScreenProvider>(context, listen: false)
              .changeValueOfScreen(buttonValue);
        } else {
          Provider.of<ScreenProvider>(context, listen: false)
              .mathOperation(buttonValue);
        }
        if (buttonValue == 'AC') {
          Provider.of<ScreenProvider>(context, listen: false)
              .resetValueOfScreen();
        }
        if(buttonValue=='+-'){
          Provider.of<ScreenProvider>(context, listen: false)
              .changeCharOfValue();
        }
        if(buttonValue=='%'){
          Provider.of<ScreenProvider>(context, listen: false)
              .percentOfValue();
        }
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: bgColor,
          foregroundColor: txtColor),
      child: Text(buttonValue, style: const TextStyle(fontSize: 34)),
    );
  }
}
