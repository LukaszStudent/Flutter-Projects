import 'package:flutter/material.dart';

class ScreenProvider extends ChangeNotifier {
  String currentValue;
  ScreenProvider({this.currentValue = '0'});

  void changeValueOfScreen(String newValue) {
    if (newValue != '0' && currentValue == '0') {
      currentValue = newValue;
    } else {
      currentValue.substring(1);
      currentValue += newValue;
    }

    // for (int i = 0; i < currentValue.length; i++) {
        //print(i);
        //print(i);
        
        
      // }
if(currentValue.length==5){
  print('piec');
          currentValue= currentValue.substring(0,currentValue.length-3)+' '+currentValue.substring(currentValue.length-3);
        }

    if(currentValue.length==7){
      print('siedem');
      String connected=currentValue.replaceAll(' ', '');
          currentValue= connected.substring(0,3)+' '+connected.substring(3);
        
        }

    if(currentValue.length==8){
      print('osiem');
      String connected=currentValue.replaceAll(' ', '');
      print(connected);
          currentValue= connected[0]+' '+connected.substring(1,4)+' '+connected.substring(4,7);
        
        } 
    if(currentValue.length==10){
      print('dzwic');
      String connected=currentValue.replaceAll(' ', '');
          currentValue= connected.substring(0,2)+' '+connected.substring(2,5)+' '+connected.substring(5,8);
        
        }
    


    if (currentValue.length >= 11) {
      String connected=currentValue.replaceAll(' ', '');
          currentValue= connected.substring(0,3)+' '+connected.substring(3,6)+' '+connected.substring(6,9);
        
      currentValue = currentValue.substring(0, 11);
    }
    notifyListeners();
  }

  void resetValueOfScreen() {
    currentValue = '0';
    notifyListeners();
  }
}
