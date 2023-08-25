import 'package:flutter/material.dart';

class ScreenProvider extends ChangeNotifier {
  String currentValue;
  double prevValuePlusMinus;
  double prevValueMultiDiv;
  bool action;
  ScreenProvider(
      {this.currentValue = '0', this.prevValueMultiDiv=1,this.prevValuePlusMinus = 0, this.action = false});

  void changeValueOfScreen(String newValue) {
    if (action == true) {
      currentValue = '0';
    }
    action = false;
    if (newValue != '0' && currentValue == '0') {
      currentValue = newValue;
    } else {
      currentValue.substring(1);
      currentValue += newValue;
    }
    visualValueOfScreen();
    notifyListeners();
  }

  void visualValueOfScreen() {
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
  }

  void resetValueOfScreen() {
    currentValue = '0';
    prevValuePlusMinus = 0;
    notifyListeners();
  }

  void changeCharOfValue() {
    if (currentValue[0] == '-') {
      currentValue = currentValue.substring(1);
    } else {
      currentValue = '-$currentValue';
    }
  }

  void percentOfValue() {
    double result =
        double.parse(currentValue.replaceAll(' ', '').replaceAll(',', '.'));
    result /= 100;
    currentValue = result.toString().replaceAll('.', ',');
  }

  void mathOperation(String mathAction) {
    action = true;
    if (mathAction == '-') {
      prevValuePlusMinus -= double.parse(currentValue);
      currentValue = prevValuePlusMinus.toString().replaceAll('.', ',');
    } else if (mathAction == '+') {
      prevValuePlusMinus += double.parse(currentValue);
      currentValue = prevValuePlusMinus.toString().replaceAll('.', ',');
    } else if (mathAction == 'x') {
      prevValueMultiDiv *= double.parse(currentValue);
      currentValue = prevValueMultiDiv.toString().replaceAll('.', ',');
    } else {
      prevValueMultiDiv /= double.parse(currentValue);
      currentValue = prevValueMultiDiv.toString().replaceAll('.', ',');
    }
    notifyListeners();
  }

  void mathResult() {
    currentValue = prevValuePlusMinus.toString();
    notifyListeners();
  }
}
