import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonValue;
  final Color? bgColor;
  const CustomButton({super.key, required this.buttonValue, this.bgColor=const Color.fromRGBO(66, 66, 66, 1)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(shape: const CircleBorder(),backgroundColor: bgColor),
      child: Text(buttonValue,style: const TextStyle(fontSize: 34,),),
    );
  }
}
