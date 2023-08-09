import 'package:flutter/material.dart';
import 'package:flutter_timer/provider/prvdr.dart';
import 'package:flutter_timer/timer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<TimeService>(
      create: (_) => TimeService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreenHome(),
    );
  }
}
