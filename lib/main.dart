import 'package:flutter/material.dart';
import 'package:timerapp/simple_timer_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SimpleTimerApp(),
    );
  }
}
