import 'package:flashcards/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('FlashCards'),centerTitle: true,),//leading: IconButton(onPressed: (){}, icon: Icon(Icons.list_rounded)),),
      drawer: MyDrawer(),
    );
  }
}