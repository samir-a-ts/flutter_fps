import 'package:flutter/material.dart';
import 'package:flutter_fps/features/fps/screens/fps_counter_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FpsCounterScreen(),
    );
  }
}
