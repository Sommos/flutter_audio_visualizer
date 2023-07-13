import 'package:flutter/material.dart';
import 'dart:math';

import '../visualizer/round_visualizer_painter.dart';

class RoundVisualizerScreen extends StatefulWidget {
  const RoundVisualizerScreen({super.key});

  @override
  State<RoundVisualizerScreen> createState() => _RoundVisualizerScreenState();
}

class _RoundVisualizerScreenState extends State<RoundVisualizerScreen> 
  with SingleTickerProviderStateMixin {
    late AnimationController animationController;
    List<double> barsHeight = [];

    @override
    void initState() {
      super.initState();
      animationController = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..addListener(() {
        setState(() {});
      });
    }

    @override
    void dispose() {
      animationController.dispose();
      super.dispose();
    }

    void updateBars(List<double> audioData) {
      setState(() {
        barsHeight = audioData;
      });
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Audio Visualizer"),
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final radius = min(constraints.maxWidth, constraints.maxHeight) / 2;
                return CustomPaint(
                  painter: RoundVisualizerPainter(
                    barsHeight: barsHeight,
                    animationValue: animationController.value,
                    radius: radius,
                  ),
                  child: Container(),
                );
              },
            ),
          ),
        ),
      );
    }
}