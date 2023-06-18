
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
class MyClock extends StatefulWidget {
  const MyClock({ Key? key }) : super(key: key);
  @override
  _MyClockState createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );}
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountDownController _controller = CountDownController();

  bool isVisible_1=false;
  bool isVisible_2=false;
  bool isVisible_3=false;
  bool isVisible_4=false;
  int licznik=0;
  int seconds=0;
  int minutes=25;
  int zero=0;

  void obrazk(){
    print(licznik);
    licznik++;
    if(licznik==1){
      isVisible_1=true;
    }
    if(licznik==3){
      isVisible_2=true;
    }
    if(licznik==5){
      isVisible_3=true;
    }
    if(licznik==7){
      isVisible_4=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //   Visibility(
          //     visible: isVisible_1,
          //     maintainSize: true,
          //     maintainAnimation: true,
          //     maintainState: true,
          //     child: Image(image: AssetImage('obrazki/pomidorek.png'),
          //     height: 60,
          //     width: 60,)
          //   ),
          //   Visibility(
          //     visible: isVisible_2,
          //     maintainSize: true,
          //     maintainAnimation: true,
          //     maintainState: true,
          //     child: Image(image: AssetImage('obrazki/pomidorek.png'),
          //     height: 60,
          //     width: 60,)
          //   ),
          //   Visibility(
          //     visible: isVisible_3,
          //     maintainSize: true,
          //     maintainAnimation: true,
          //     maintainState: true,
          //     child: Image(image: AssetImage('obrazki/pomidorek.png'),
          //     height: 60,
          //     width: 60,)
          //   ),
          //   Visibility(
          //     visible: isVisible_4,
          //     maintainSize: true,
          //     maintainAnimation: true,
          //     maintainState: true,
          //     child: Image(image: AssetImage('obrazki/pomidorek.png'),
          //     height: 60,
          //     width: 60,)
          //   ),
          // ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CircularCountDownTimer(
            // Countdown duration in Seconds.
            duration: minutes,
            // Countdown initial elapsed Duration in Seconds.
            initialDuration: zero,
            // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
            controller: _controller,
            // Width of the Countdown Widget.
            width: 300,
            // Height of the Countdown Widget.
            height: 200,
            // Ring Color for Countdown Widget.
            ringColor: Colors.green,
            // Ring Gradient for Countdown Widget.
            ringGradient: null,
            // Filling Color for Countdown Widget.
            fillColor: Colors.blue,
            // Filling Gradient for Countdown Widget.
            fillGradient: null,
            // Background Color for Countdown Widget.
            backgroundColor: Colors.white,
            // Background Gradient for Countdown Widget.
            backgroundGradient: null,
            // Border Thickness of the Countdown Ring.
            strokeWidth: 20.0,
            // Begin and end contours with a flat edge and no extension.
            strokeCap: StrokeCap.round,
            // Text Style for Countdown Text.
             onComplete: () {

              obrazk();
              minutes=5;
              _controller.restart();
              minutes=10;
              setState(() {
                
              });
            },

                

            // Format for the Countdown Text.
            textFormat: CountdownTextFormat.S,
            // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: true,
               )],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    _controller.resume();
                  },
                  // color: Colors.white,
                  // shape: CircleBorder(side: BorderSide(color: Colors.blue) 
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                  
                          child: Text(
                    "Resume",
                    style: TextStyle(
                    color: Colors.green,
                    fontSize: 24
                    ),
                  ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    _controller.pause();
                  },
                  // color: Colors.blue,
                  // shape: CircleBorder(side: BorderSide(color: Colors.white) 
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                  
                  child: Text(
                    "Pause",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                    ),
                  ),
                  ),
                ),
              ],
            ), 
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Visibility(
              visible: isVisible_1,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Image(image: AssetImage('obrazki/pomidorek.png'),
              height: 60,
              width: 60,)
            ),
            Visibility(
              visible: isVisible_2,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Image(image: AssetImage('obrazki/pomidorek.png'),
              height: 60,
              width: 60,)
            ),
            Visibility(
              visible: isVisible_3,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Image(image: AssetImage('obrazki/pomidorek.png'),
              height: 60,
              width: 60,)
            ),
            Visibility(
              visible: isVisible_4,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Image(image: AssetImage('obrazki/pomidorek.png'),
              height: 60,
              width: 60,)
            ),
          ],
          ),
            ],
            
            )
    );
  }
}