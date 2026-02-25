import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasbih_counter/const/text_style_widgets.dart';

class Tasbih_activity extends StatefulWidget{
  @override
  State<Tasbih_activity> createState()=> _tasbih_widgets();
  
}

class _tasbih_widgets extends State<Tasbih_activity>{

  int count = 0;
//
  bool switchValue = false;

  void toggleSwitch(bool value){
    setState(() {
      count++;
          switchValue = true;
    });

    Future.delayed(Duration(milliseconds: 150),(){
      setState(() {
        switchValue = false;
      });
    });
  }

  void _Increment (){
    setState(() {
      count++;
    });
  }

  void _Reset(){
    setState(() {
      count = 0;
    });
  }



  //StopWatch Start
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  String formattedTime = "00:00:00";

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        formattedTime = formatTime(stopwatch.elapsedMilliseconds);
      });
    });
  }

  String formatTime(int milliseconds) {
    int seconds = milliseconds ~/ 1000;
    int minutes = seconds ~/ 60;
    int hours = minutes ~/ 60;

    seconds = seconds % 60;
    minutes = minutes % 60;

    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }
  //StopWatch End

  //StopWatch Formate and Value
  void resetCounter() {
    setState(() {
      count = 0;
      stopwatch.reset();
      formattedTime = "00:00:00";
    });
  }

  void startStopwatch() {
    stopwatch.start();
    startTimer();
  }

  void stopStopwatch() {
    stopwatch.stop();
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  //StopWatch Formate and Value End




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //     padding: EdgeInsets.all(10),
        //   child: Text("Home"),
        // ),
        title: Text("Tasbih Counter", style: AppTextStyle.titleBlack16),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffCEC5D8),
                  image: DecorationImage(
                      image: AssetImage("assets/images/bell-outline.png"))

              ),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 450,
              width: MediaQuery
                  .sizeOf(context)
                  .width,
              //color: Colors.grey,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff764CA5),
                  image: DecorationImage(
                      image: AssetImage("assets/images/Counter_Page_BG.png"),
                      fit: BoxFit.cover,
                      opacity: .20
                  )
              ),

              child: Column(
                children: [
                  //Arabic Text part
                  SizedBox(height: 40,),
                  Container(
                    child: Text("الله أكبر", style: AppTextStyle.arabicText20,),
                  ),

                  //Stopwatch
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    // alignment: Alignment.center,
                    // width: 80,
                    // height: 30,
                    // color: Color(0xFFFFFFFF),
                    child: Text(formattedTime,
                      //formattedTime,
                      style: AppTextStyle.stopwatchText14,),
                  ),

                  SizedBox(height: 30,),
                  Container(
                    child: Text("Tasbih Counter",
                      style: AppTextStyle.tasbihCounterText20,),
                  ),

                  SizedBox(height: 30,),
                  Container(
                    child: Text(
                      '$count', style: AppTextStyle.tasbihCountText20White,),
                  ),

                  SizedBox(height: 30,),
                  SizedBox(
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Switch(
                        value: switchValue,
                        onChanged: toggleSwitch,
                      ),
                    )
                  ),


                  SizedBox(height: 30,),
                  //Container(child: Text("Text 6"),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ElevatedButton(onPressed: (){setState(() {
                        count = 0;
                        stopwatch.reset();
                        formattedTime;
                      });}, child: Icon(Icons.refresh, fontWeight: FontWeight.bold, size: 20,),),

                      SizedBox(width: 30,),
                      ElevatedButton(onPressed: stopStopwatch, child: Text("Stop")),

                      SizedBox(width: 30,),
                      ElevatedButton(onPressed: startStopwatch, child: Icon(Icons.play_arrow))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),

    );

  }
  
}