import 'package:flashcards/widgets/inputtext.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFormField(controller: _emailController, suffixIconButton: Icons.email_outlined,),
              MyTextFormField(controller: _passwordController, suffixIconButton: Icons.remove_red_eye_outlined,)
            ],
          ),
        ),
      ),
    );
  }
}
