import 'package:flutter/material.dart';

import '../visualizer/round_visualizer_screen.dart';

class RoundVisualizerApp extends StatelessWidget {
  const RoundVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Audio Visualizer",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RoundVisualizerScreen(),
    );
  }
}