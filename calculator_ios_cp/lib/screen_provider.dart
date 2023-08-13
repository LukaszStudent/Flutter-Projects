import 'package:flutter/material.dart';

class ScreenProvider extends ChangeNotifier {
  String currentValue;
  double prevValue;
  bool action;
  ScreenProvider(
      {this.currentValue = '0', this.prevValue = 0, this.action = false});

  void changeValueOfScreen(String newValue) {
    if (newValue != '0' && currentValue == '0') {
      currentValue = newValue;
    } else {
      currentValue.substring(1);
      currentValue += newValue;
    }

    if (currentValue.length == 5) {
      currentValue =
          '${currentValue.substring(0, currentValue.length - 3)} ${currentValue.substring(currentValue.length - 3)}';
    }

    if (currentValue.length == 7) {
      String connected = currentValue.replaceAll(' ', '');
      currentValue = '${connected.substring(0, 3)} ${connected.substring(3)}';
    }

    if (currentValue.length == 8) {
      String connected = currentValue.replaceAll(' ', '');
      currentValue =
          '${connected[0]} ${connected.substring(1, 4)} ${connected.substring(4, 7)}';
    }
    if (currentValue.length == 10) {
      String connected = currentValue.replaceAll(' ', '');
      currentValue =
          '${connected.substring(0, 2)} ${connected.substring(2, 5)} ${connected.substring(5, 8)}';
    }

    if (currentValue.length >= 11) {
      String connected = currentValue.replaceAll(' ', '');
      currentValue =
          '${connected.substring(0, 3)} ${connected.substring(3, 6)} ${connected.substring(6, 9)}';
      currentValue = currentValue.substring(0, 11);
    }
    notifyListeners();
  }

  void resetValueOfScreen() {
    currentValue = '0';
    notifyListeners();
  }

  void changeCharOfValue(){
    if(currentValue[0]=='-'){
      currentValue=currentValue.substring(1);
    }
    else{
      currentValue='-$currentValue';
    }
  }

  void percentOfValue(){
    double result=double.parse(currentValue.replaceAll(' ', '').replaceAll(',', '.'));
    result/=100;
    currentValue=result.toString().replaceAll('.', ',');
  }

  void mathOperation(String mathAction) {
    action = true;
    prevValue = double.parse(currentValue.replaceAll(' ', '').replaceAll(',', '.'));
    currentValue = '0';
    notifyListeners();
  }

  void mathResult() {
    // currentValue=prevValue
  }
}
