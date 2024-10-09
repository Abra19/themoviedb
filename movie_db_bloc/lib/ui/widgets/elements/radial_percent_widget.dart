import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';

class RadialPercentWidget extends StatelessWidget {
  const RadialPercentWidget({
    super.key,
    required this.percent,
    required this.lineWidth,
    required this.lineColor,
    required this.fillColor,
    required this.freeColor,
  });
  final double percent;
  final double lineWidth;
  final Color lineColor;
  final Color fillColor;
  final Color freeColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CustomPaint(
          painter: MyPaint(
            percent: percent,
            lineWidth: lineWidth,
            lineColor: lineColor,
            fillColor: fillColor,
            freeColor: freeColor,
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(lineWidth * 2.5),
            child: PercentLabelWidget(percent: percent),
          ),
        ),
      ],
    );
  }
}

class MyPaint extends CustomPainter {
  MyPaint({
    super.repaint,
    required this.percent,
    required this.lineWidth,
    required this.lineColor,
    required this.fillColor,
    required this.freeColor,
  }) : percentage = percent / 100;

  final double percent;
  final double lineWidth;
  final Color lineColor;
  final Color fillColor;
  final Color freeColor;
  final double percentage;

  Rect calculateRect(Size size) =>
      Offset(lineWidth * 1.5, lineWidth * 1.5) &
      Size(size.width - lineWidth * 3, size.height - lineWidth * 3);

  void _drawBackground(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  void _drawFilled(Canvas canvas, Rect arcRect) {
    final Paint paint = Paint();
    paint.color = lineColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      percentage * 2 * pi,
      false,
      paint,
    );
  }

  void _drawFree(Canvas canvas, Rect arcRect) {
    final Paint paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      percentage * 2 * pi - pi / 2,
      (1 - percentage) * 2 * pi,
      false,
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect = calculateRect(size);
    _drawBackground(canvas, size);
    _drawFree(canvas, arcRect);
    _drawFilled(canvas, arcRect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PercentLabelWidget extends StatelessWidget {
  const PercentLabelWidget({super.key, required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final String text = percent != 0 ? '${percent.toInt()}%' : 'NR';
    return Text(
      text,
      style: AppTextStyle.likesPercentageTextStyle,
    );
  }
}
