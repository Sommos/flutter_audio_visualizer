import 'package:flutter/material.dart';

import 'round_visualizer_screen_state.dart';

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