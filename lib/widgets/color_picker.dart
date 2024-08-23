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
            //    child: ColorPicker(size: 225),
            ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final double size;
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  ColorPicker({
    required this.size,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color selectedColor;
  double brightness = 1.0;
  double saturation = 1.0;
  double hue = 0.0;
  Offset selectorPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
    final hsvColor = HSVColor.fromColor(selectedColor);
    hue = hsvColor.hue;
    saturation = hsvColor.saturation;
    brightness = hsvColor.value;
    _updateSelectorPosition(hue * pi / 180);
  }

  void _updateSelectorPosition(double angle) {
    final ringWidth = 18.0;
    final ringRadius = (widget.size / 2) - 10.0;
    final middleRingRadius = ringRadius - ringWidth / 2;

    selectorPosition = Offset(
      widget.size / 2 + middleRingRadius * cos(angle),
      widget.size / 2 + middleRingRadius * sin(angle),
    );
  }

  void _updateColor(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final direction = position - center;
    final angle = atan2(direction.dy, direction.dx);
    hue = (angle * 180 / pi + 360) % 360;

    setState(() {
      selectedColor =
          HSVColor.fromAHSV(1, hue, saturation, brightness).toColor();
      widget.onColorChanged(
          selectedColor); // Notify the parent of the color change
      _updateSelectorPosition(angle);
    });
  }

  void _updateBrightness(double value) {
    setState(() {
      brightness = value;
      selectedColor =
          HSVColor.fromAHSV(1, hue, saturation, brightness).toColor();
      widget.onColorChanged(
          selectedColor); // Notify the parent of the color change
    });
  }

  void _updateSaturation(double value) {
    setState(() {
      saturation = value;
      selectedColor =
          HSVColor.fromAHSV(1, hue, saturation, brightness).toColor();
      widget.onColorChanged(
          selectedColor); // Notify the parent of the color change
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurvedSlider(
          startAngle: -pi,
          sweepAngle: pi,
          size: widget.size,
          value: brightness,
          onChanged: _updateBrightness,
          label: 'Brightness',
        ),
        GestureDetector(
          onPanUpdate: (details) {
            final localPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(details.globalPosition);
            _updateColor(localPosition, Size(widget.size, widget.size));
          },
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter:
                ColorWheelPainter(selectedColor, selectorPosition, widget.size),
          ),
        ),
        CurvedSlider(
          startAngle: pi,
          sweepAngle: -pi,
          size: widget.size,
          value: saturation,
          onChanged: _updateSaturation,
          label: 'Saturation',
        ),
      ],
    );
  }
}

class CurvedSlider extends StatelessWidget {
  final double size;
  final double value;
  final ValueChanged<double> onChanged;
  final String label;
  final double startAngle; // Added
  final double sweepAngle; // Added

  CurvedSlider({
    required this.size,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.startAngle, // Updated
    required this.sweepAngle, // Updated
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size / 8, // Further reduced height to bring sliders closer
      child: CustomPaint(
        painter: CurvedSliderPainter(value, label, startAngle, sweepAngle),
        child: GestureDetector(
          onPanUpdate: (details) {
            final localPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(details.globalPosition);
            final x = localPosition.dx / size;
            final newValue = x.clamp(0.0, 1.0);
            onChanged(newValue);
          },
        ),
      ),
    );
  }
}

class CurvedSliderPainter extends CustomPainter {
  final double value;
  final String label;
  final double startAngle; // Added
  final double sweepAngle; // Added

  CurvedSliderPainter(this.value, this.label, this.startAngle, this.sweepAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final trackPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Reduced stroke width for the slider track

    final selectorRadius = 6.0; // Size of the selector

    final path = Path()..arcTo(rect, startAngle, sweepAngle, false); // Updated

    canvas.drawPath(path, trackPaint);

    // Calculate the selector position
    final selectorAngle = startAngle + sweepAngle * value;
    final selectorPosition = Offset(
      size.width / 2 + (size.width / 2) * cos(selectorAngle),
      size.height / 2 + (size.height / 2) * sin(selectorAngle),
    );

    final selectorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(selectorPosition, selectorRadius, selectorPaint);

    // Draw the label
    final textSpan = TextSpan(
      text: label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final textOffset = Offset(
      size.width / 2 - textPainter.width / 2,
      size.height - textPainter.height - 5, // Adjust for placement
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ColorWheelPainter extends CustomPainter {
  final Color selectedColor;
  final Offset selectorPosition;
  final double size;

  ColorWheelPainter(this.selectedColor, this.selectorPosition, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final ringWidth = 18.0;
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
        stops: [0.0, 0.17, 0.33, 0.5, 0.67, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: ringRadius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    canvas.drawCircle(center, ringRadius, ringPaint);

    final innerCircleRadius =
        ringRadius - ringWidth / 2 - 20; // Adjust as needed
    final innerCirclePaint = Paint()
      ..color = selectedColor
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3); // Adjust blur radius

    canvas.drawCircle(center, innerCircleRadius, innerCirclePaint);

    final selectorRadius = 8.0; // Adjust the size of the selector
    final borderWidth = 1.25; // Width of the border

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
