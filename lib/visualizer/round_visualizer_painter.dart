import 'package:flutter/material.dart';
import 'dart:math';

class RoundVisualizerPainter extends CustomPainter {
   final List<double> barsHeight;
  final double animationValue;
  final double radius;

  RoundVisualizerPainter({
    required this.barsHeight,
    required this.animationValue,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final barWidth = 2 * pi / barsHeight.length;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    for (int i = 0; i < barsHeight.length; i++) {
      final barHeight = barsHeight[i] * radius * animationValue;
      final angle = i * barWidth;
      final x = centerX + (radius * cos(angle));
      final y = centerY + (radius * sin(angle));

      final startPoint = Offset(x, y);
      final endPoint = Offset(x, y - barHeight);

      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(RoundVisualizerPainter oldDelegate) {
    return oldDelegate.barsHeight != barsHeight ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.radius != radius;
  }
}