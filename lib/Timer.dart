import 'dart:async';

import 'package:flutter/material.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  var pomType = 'work';
  Map<String, Duration> pomodoroDuration = {
    'work': Duration(minutes: 25),
    'break': Duration(minutes: 5)
  };

  late Duration? _timerDuration = pomodoroDuration[pomType];
  Timer? countdownTimer;
  bool isButtonDisabled = false;

  void startTimer() {
    isButtonDisabled = true;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration!.inSeconds <= 0) {
          countdownTimer?.cancel();
        } else {
          _timerDuration = Duration(seconds: _timerDuration!.inSeconds - 1);
        }
      });
    });
  }

  void stopTimer() {
    isButtonDisabled = false;
    setState(() => countdownTimer!.cancel());
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    _timerDuration!.inMinutes.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    "min",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    _timerDuration!.inSeconds
                        .remainder(60)
                        .toString()
                        .padLeft(2, '0'),
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    "sec",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: isButtonDisabled
                    ? null
                    : () {
                        startTimer();
                      },
                child: Text(
                  "Start",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  stopTimer();
                },
                child: Text(
                  "Pause",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isButtonDisabled = false;
                    countdownTimer?.cancel();
                    _timerDuration = pomodoroDuration[pomType];
                  });
                },
                child: Text(
                  "Restart",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
