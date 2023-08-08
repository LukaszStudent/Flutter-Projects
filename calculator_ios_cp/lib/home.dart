import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CustomButton> buttons = [
    const CustomButton(buttonValue: 'AC'),
    const CustomButton(buttonValue: '+-'),
    const CustomButton(buttonValue: '%'),
    const CustomButton(buttonValue: '/',bgColor: Colors.orange,),
    const CustomButton(buttonValue: '7'),
    const CustomButton(buttonValue: '8'),
    const CustomButton(buttonValue: '9'),
    const CustomButton(buttonValue: 'x',bgColor: Colors.orange,),
    const CustomButton(buttonValue: '4'),
    const CustomButton(buttonValue: '5'),
    const CustomButton(buttonValue: '6'),
    const CustomButton(buttonValue: '-',bgColor: Colors.orange,),
    const CustomButton(buttonValue: '1'),
    const CustomButton(buttonValue: '2'),
    const CustomButton(buttonValue: '3'),
    const CustomButton(buttonValue: '+',bgColor: Colors.orange,),
    const CustomButton(buttonValue: '0'),
    const CustomButton(buttonValue: ','),
    const CustomButton(buttonValue: '=',bgColor: Colors.orange,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          Text('witam'),
          Align(
            alignment: Alignment.bottomCenter,
            child: GridView.count(
              padding: const EdgeInsets.all(20.0),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 4,
              shrinkWrap: true,
              children: buttons,
            ),
          ),
        ],
      ),
    );
  }
}
