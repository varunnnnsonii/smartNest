import 'package:flutter/material.dart';
import 'dart:math';

class CircularSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double currentValue;
  final Function(double) onChange;

  CircularSlider({
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.onChange,
  });

  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  late double _angle;

  @override
  void initState() {
    super.initState();
    _angle = _getAngle(widget.currentValue);
  }

  double _getAngle(double value) {
    final range = widget.maxValue - widget.minValue;
    return (value - widget.minValue) / range * 2 * pi;
  }

  double _getValue(double angle) {
    final range = widget.maxValue - widget.minValue;
    return widget.minValue + (angle / (2 * pi)) * range;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final size = MediaQuery.of(context).size.width;
        final center = Offset(size / 2, size / 2);
        final position = details.localPosition;
        final angle = atan2(position.dy - center.dy, position.dx - center.dx) + pi / 2;
        final newAngle = (angle + 2 * pi) % (2 * pi); // Normalize angle
        setState(() {
          _angle = newAngle;
          final newValue = _getValue(newAngle).clamp(widget.minValue, widget.maxValue);
          widget.onChange(newValue);
        });
      },
      child: CustomPaint(
        size: Size(200, 200),
        painter: CircularSliderPainter(_angle),
        child: Center(
          child: Text(
            '${widget.currentValue.toStringAsFixed(1)}°C',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class CircularSliderPainter extends CustomPainter {
  final double angle;

  CircularSliderPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    canvas.drawCircle(center, radius, paint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
