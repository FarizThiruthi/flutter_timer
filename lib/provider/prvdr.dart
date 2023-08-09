import 'dart:async';
import 'package:flutter/material.dart';

class TimeService extends ChangeNotifier {
  late Timer timer;
  double currentDuration = 0; // Initialize to 0 initially
  double selectedTime = 0; // Initialize to 0 initially
  bool timerPlaying = false;

  static List<String> selectedTimes = [
    '300',
    '600',
    '900',
    '1200',
    '1500',
    '1800',
    '2100',
    '2400',
    '2700',
    '3000',
    '3300',
    '3600'
  ];

  void pause() {
    if (timer != null && timer.isActive) {
      timer.cancel();
      timerPlaying = false;
      notifyListeners();
    }
  }

  void start() {
    if (!timerPlaying) {
      timerPlaying = true;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (currentDuration == 0) {
          timer.cancel();
          currentDuration = selectedTime;
          timerPlaying = false;
          notifyListeners();
        } else {
          currentDuration--;
          notifyListeners();
        }
      });
    }
  }

  void reset() {
    timer.cancel();
    currentDuration = 0;
    timerPlaying = false;
    selectedTime=0;
    notifyListeners();
  }

  void selectTime(double seconds) {
    selectedTime = seconds;
    currentDuration = seconds;
    notifyListeners();
  }
}
