import 'dart:math' as math show pi;

import 'package:flutter/material.dart';

enum ClockHand { hour, minute, second }

class GenericPainterComponent extends CustomPainter {
  final Paint handPaint;

  final ClockHand clockHand;
  final int hours;
  final int minutes;
  final int seconds;

  GenericPainterComponent({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.clockHand = ClockHand.hour,
  }) : handPaint = Paint() {
    handPaint.style = PaintingStyle.stroke;
    handPaint.strokeWidth = 4.0;
    handPaint.color = Colors.indigo;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    switch (clockHand) {
      case ClockHand.hour:
        canvas.rotate(
          hours >= 12
              ? 2 * math.pi * ((hours - 12) / 12 + (minutes / 720))
              : 2 * math.pi * ((hours / 12) + (minutes / 720)),
        );

        final path = Path();
        path.lineTo(0.0, -radius + radius / 2.5);
        path.close();

        canvas.drawPath(path, handPaint);
        break;

      case ClockHand.minute:
        canvas.rotate(
          2 * math.pi * ((minutes + (seconds / 60)) / 60),
        );

        final path = Path();
        path.lineTo(-8.5, -radius + 20.0);
        path.close();

        canvas.drawPath(path, handPaint);
        break;

      case ClockHand.second:
        canvas.rotate(2 * math.pi * seconds / 60);

        final path = Path();
        path.lineTo(0.0, -radius + 5.0);

        canvas.drawPath(path, handPaint);
        break;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
