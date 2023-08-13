import 'package:calculator_ios_cp/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CustomButton> buttons = [
    const CustomButton(buttonValue: 'AC',bgColor: Colors.grey,txtColor: Colors.black,),
    const CustomButton(buttonValue: '+-',bgColor: Colors.grey,txtColor: Colors.black,),
    const CustomButton(buttonValue: '%',bgColor: Colors.grey,txtColor: Colors.black,),
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
    String currentValue=Provider.of<ScreenProvider>(context).currentValue;
    double fontSize=calculateLength(currentValue);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Text(currentValue,style: TextStyle(fontSize: fontSize),),
          ),
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


  double calculateLength(String text){
    if(text.length==7){
      return 90;
    }
    else if(text.length==9){
      return 75;
    }
    else if(text.length==10){
      return 65;
    }
    else if(text.length>=11){
      return 60;
    }
    else{
      return 95;
    }
  }
}
