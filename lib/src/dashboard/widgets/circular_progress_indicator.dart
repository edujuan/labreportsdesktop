import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/data.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double progress;
  final double radius;
  final Gradient progressGradient;
  final double strokeWidth;
  final Color endCircleColor;

  const CustomCircularProgressIndicator({
    super.key,
    required this.progress,
    required this.progressGradient,
    this.radius = 100.0,
    this.strokeWidth = 10.0,
    this.endCircleColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(radius * 2, radius * 2),
      painter: _CustomArcPainter(
        progress: progress,
        progressGradient: progressGradient, // Pass the gradient
        strokeWidth: strokeWidth,
        endCircleColor: endCircleColor,
      ),
    );
  }
}

class _CustomArcPainter extends CustomPainter {
  final double progress;
  final Gradient progressGradient;
  final double strokeWidth;
  final Color endCircleColor;

  _CustomArcPainter({
    required this.progress,
    required this.progressGradient,
    required this.strokeWidth,
    required this.endCircleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Draw the progress arc
    final paint = Paint()
      ..shader = progressGradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );

    // Draw the end circle
    final endCirclePaint = Paint()
      ..color = endCircleColor
      ..style = PaintingStyle.fill;

    final progressRadians = 2 * math.pi * progress;
    final endCircleCenter = Offset(
      center.dx + radius * math.cos(progressRadians - math.pi / 2),
      center.dy + radius * math.sin(progressRadians - math.pi / 2),
    );

    canvas.drawCircle(endCircleCenter, strokeWidth / 2, endCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CircularStatus extends StatelessWidget {
  final Iterable<Biomarker> biomarkers;
  final double size;
  final bool showSubtitle;

  const CircularStatus({
  super.key,
  required this.biomarkers,
  this.size = 200.0,
  this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final totalCount = biomarkers.length;
    final inRangeCount = biomarkers.where((e) => !e.isOutOfRange).length;
    final progressValue = inRangeCount / totalCount;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: size * 1.3,
          height: size * 1.3,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        CustomCircularProgressIndicator(
          progress: progressValue,
          radius: size / 2,
          progressGradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(.2),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          strokeWidth: size / 8,
          endCircleColor: Theme.of(context).primaryColor,
        ),
        Column(
          children: [
            Text(
              '$inRangeCount/$totalCount',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: size / 4.9),
            ),
            if (showSubtitle)
              Text(
                'in range',
                style: TextStyle(
                  fontSize: size / 12,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.color
                      ?.withOpacity(.5),
                ),
              ),
          ],
        ),
      ],
    );
  }
}