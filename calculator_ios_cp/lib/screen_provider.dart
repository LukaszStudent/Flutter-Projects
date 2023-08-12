import 'package:flutter/material.dart';

class ScreenProvider extends ChangeNotifier{
  String currentValue;
  ScreenProvider({this.currentValue='0'});

  void changeValueOfScreen(String newValue){
    currentValue+=newValue;
    notifyListeners();
  }

  void resetValueOfScreen(){
    currentValue='0';
    notifyListeners();
  }
}