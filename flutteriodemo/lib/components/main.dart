import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(home: ComponentsDemo()));
}

class ComponentsDemo extends StatefulWidget {
  @override
  _ComponentsDemoState createState() => _ComponentsDemoState();
}

class _ComponentsDemoState extends State<ComponentsDemo> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    Color hueColor = HSLColor.fromAHSL(1, _value, 1, 0.5).toColor();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SliderTheme(
              data: SliderThemeData(
                  trackHeight: 8,
                  trackShape: _HueTrackShape(),
                  thumbColor: Colors.grey),
              child: Slider(
                  value: _value,
                  min: 0,
                  max: 360,
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue;
                    });
                  }),
            ),
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: hueColor)),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              ),
              cursorColor: hueColor,
              style: TextStyle(color: hueColor),
              textInputAction: TextInputAction.newline,
              minLines: 2,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class _HueTrackShape extends RectangularSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset,
      {@required RenderBox parentBox,
      @required SliderThemeData sliderTheme,
      @required Animation<double> enableAnimation,
      @required TextDirection textDirection,
      @required Offset thumbCenter,
      bool isDiscrete = false,
      bool isEnabled = false}) {
    Rect rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );
    LinearGradient gradient = LinearGradient(colors: _hueColors);
    Paint paint = Paint()..shader = gradient.createShader(rect);
    context.canvas.drawRect(rect, paint);
  }
}

const _hueColors = [
  Color(0xFFFF0000),
  Color(0xFFFFFF00),
  Color(0xFF00FF00),
  Color(0xFF00FFFF),
  Color(0xFF0000FF),
  Color(0xFFFF00FF),
  Color(0xFFFF0000),
];

class _RainbowTriangularTrackShape extends RectangularSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset,
      {RenderBox parentBox,
      SliderThemeData sliderTheme,
      Animation<double> enableAnimation,
      Offset thumbCenter,
      bool isEnabled = false,
      bool isDiscrete = false,
      TextDirection textDirection}) {
    final Rect trackRect = getPreferredRect(
        parentBox: parentBox,
        offset: offset,
        sliderTheme: sliderTheme,
        isEnabled: isEnabled,
        isDiscrete: isDiscrete);
    LinearGradient leftRainbowGradient = LinearGradient(colors: <Color>[
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple
    ]);

    LinearGradient rightGradient = LinearGradient(colors: <Color>[
      Colors.white,
      Colors.black,
      Colors.white,
    ]);

    final Rect leftTrackSegment = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom);
    Paint leftPaint = Paint()
      ..shader = leftRainbowGradient.createShader(leftTrackSegment);
    context.canvas.drawPath(_rightArrowTriangle(leftTrackSegment), leftPaint);
    final Rect rightTrackSegment = Rect.fromLTRB(
        thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom);
    Paint rightPaint = Paint()
      ..shader = rightGradient.createShader(rightTrackSegment);
    context.canvas.drawPath(_leftArrowTriangle(rightTrackSegment), rightPaint);
  }
}

class _TriangularThumbShape extends SliderComponentShape {
  static const double _thumbSize = 4.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    final Path thumbPath = _triangle(size, thumbCenter);
    canvas.drawPath(
        thumbPath, Paint()..color = colorTween.evaluate(enableAnimation));
  }
}

Path _triangle(double size, Offset thumbCenter, {bool invert = false}) {
  final Path thumbPath = Path();
  final double height = sqrt(3.0) / 2.0;
  final double halfSide = size / 2.0;
  final double centerHeight = size * height / 3.0;
  final double sign = invert ? -1.0 : 1.0;
  thumbPath.moveTo(
      thumbCenter.dx - halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.lineTo(thumbCenter.dx, thumbCenter.dy - 2.0 * sign * centerHeight);
  thumbPath.lineTo(
      thumbCenter.dx + halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.close();
  return thumbPath;
}

Path _leftArrowTriangle(Rect rect) {
  final Path path = Path();
  path.moveTo(rect.left, rect.center.dy);
  path.lineTo(rect.right, rect.top);
  path.lineTo(rect.right, rect.bottom);
  path.close();
  return path;
}

Path _rightArrowTriangle(Rect rect) {
  final Path path = Path();
  path.moveTo(rect.right, rect.center.dy);
  path.lineTo(rect.left, rect.top);
  path.lineTo(rect.left, rect.bottom);
  path.close();
  return path;
}
