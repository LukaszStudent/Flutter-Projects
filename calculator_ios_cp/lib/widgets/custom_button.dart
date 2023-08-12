import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen_provider.dart';

class CustomButton extends StatelessWidget {
  final Function()? function;
  final String buttonValue;
  final Color? txtColor;
  final Color? bgColor;
  const CustomButton({super.key, required this.buttonValue, this.bgColor=const Color.fromRGBO(66, 66, 66, 1), this.function, this.txtColor=Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        bgColor==Color.fromRGBO(66, 66, 66, 1)? Provider.of<ScreenProvider>(context,listen: false).changeValueOfScreen(buttonValue):print('dzialanie');
        if(buttonValue=='AC'){
          Provider.of<ScreenProvider>(context,listen: false).resetValueOfScreen();
        }
      },
      style: ElevatedButton.styleFrom(shape: const CircleBorder(),backgroundColor: bgColor,foregroundColor: txtColor),
      child: Text(buttonValue,style: const TextStyle(fontSize: 34)),
    );
  }
}
