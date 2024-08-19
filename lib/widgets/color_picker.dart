import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(ColorPickerApp());

class ColorPickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ColorPicker(),
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color selectedColor = Colors.red;
  Offset selectorPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _updateSelectorPosition(0.0); // Initial angle set to 0 (Red)
  }

  void _updateSelectorPosition(double angle) {
    // Size is now dynamically calculated
    final ringRadius =
        (minSize() / 2) - 16.0; // Adjust for the ring's edge and width
    selectorPosition = Offset(
      minSize() / 2 + ringRadius * cos(angle),
      minSize() / 2 + ringRadius * sin(angle),
    );
  }

  void _updateColor(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final direction = position - center;
    final angle = atan2(direction.dy, direction.dx);
    final hue = (angle * 180 / pi + 360) % 360;

    setState(() {
      selectedColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
      _updateSelectorPosition(angle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final localPosition = (context.findRenderObject() as RenderBox)
            .globalToLocal(details.globalPosition);
        _updateColor(localPosition, Size(minSize(), minSize()));
      },
      child: CustomPaint(
        size: Size(minSize(), minSize()),
        painter: ColorWheelPainter(selectedColor, selectorPosition),
      ),
    );
  }

  double minSize() {
    return 300.0; // You can adjust this value based on your layout needs
  }
}

class ColorWheelPainter extends CustomPainter {
  final Color selectedColor;
  final Offset selectorPosition;

  ColorWheelPainter(this.selectedColor, this.selectorPosition);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the RGB ring
    final ringWidth = 16.0;
    final ringRadius = radius - ringWidth / 2 - 10;

    final ringPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Colors.red,
          Colors.yellow,
          Colors.green,
          Colors.cyan,
          Colors.blue,
          Colors.red,
        ],
        stops: [
          0.0,
          0.17,
          0.33,
          0.5,
          0.67,
          1.0
        ], // Ensure gradient colors are evenly spread
      ).createShader(Rect.fromCircle(center: center, radius: ringRadius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    canvas.drawCircle(center, ringRadius, ringPaint);

    // Draw the glowing inner circle with the selected color
    final innerCircleRadius =
        ringRadius - ringWidth / 2 - 20; // Adjust as needed
    final innerCirclePaint = Paint()
      ..color = selectedColor
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3); // Adjust blur radius

    canvas.drawCircle(center, innerCircleRadius, innerCirclePaint);

    // Draw the selector with the selected color and a white border
    final selectorRadius = 8.0; // Adjust the size of the selector
    final borderWidth = 1.5; // Width of the border

    final selectorPaint = Paint()
      ..color = selectedColor.withOpacity(0.6) // Slightly transparent selector
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(selectorPosition, selectorRadius, selectorPaint);
    canvas.drawCircle(
        selectorPosition, selectorRadius + borderWidth / 2, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
