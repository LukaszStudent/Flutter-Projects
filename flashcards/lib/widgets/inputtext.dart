import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? suffixIconButton;
  const MyTextFormField({super.key, required this.controller, required this.suffixIconButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Enter your username',
          suffixIcon: IconButton(icon: Icon(suffixIconButton),onPressed: (){
            if(suffixIconButton==Icons.remove_red_eye_outlined){
              suffixIconButton=Icons.visibility_off;
            }
          },),
        ),
      ),
    );
  }
}
