import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pomodoro(),
    ));

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent = 0;
  static const int DefaultTimeInMinut = 25;
  int timeInMinut = DefaultTimeInMinut;
  int timeInSec = DefaultTimeInMinut * 60;
  Timer? timer;

  void _startTimer() {
    if (timer == null || !timer!.isActive) {
      timeInSec = timeInMinut * 60;
      double secPercent = (timeInSec / 100);

      timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          if (timeInSec > 0) {
            timeInSec--;
            if (timeInSec % 60 == 0) {
              timeInMinut--;
            }
            if (timeInSec % secPercent == 0) {
              if (percent < 1) {
                percent += 0.01;
              } else {
                percent = 1;
              }
            }
          } else {
            percent = 0;
            timeInMinut = DefaultTimeInMinut;
            timer.cancel();
          }
        });
      });
    }
  }

  void _stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [const Color(0xff00695c), const Color(0xff00796b)],
            begin: FractionalOffset(0.5, 1),
          )),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  "Đồng Hồ Đếm Giờ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 140.0,
                  lineWidth: 20.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$timeInMinut",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      "Study Time",
                                      style: TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "$timeInMinut",
                                      style: const TextStyle(
                                        fontSize: 60.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      "Pause Time",
                                      style: TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    const Text(
                                      "5",
                                      style: TextStyle(
                                        fontSize: 60.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: _startTimer,
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                  ),
                                  primary: Colors.teal,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const Text(
                                    "Start",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: _stopTimer,
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                  ),
                                  primary: Colors.redAccent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const Text(
                                    "Stop",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}