import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../anypixel.dart';

class AnypixelLifeDemo extends StatefulWidget {
  @override
  AnypixelLifeDemoState createState() => AnypixelLifeDemoState();
}

class AnypixelLifeDemoState extends State<AnypixelLifeDemo>
    with SingleTickerProviderStateMixin {
  List<List<bool>> state;

  _startTimer() {
    Timer(Duration(milliseconds: 200), () {
      _updateState();
      _startTimer();
    });
  }

  _updateState() {
    setState(() {
//      print(state.toString());
      List<List<bool>> newState = List.generate(140, (_) => List(42));
      for (int x = 0; x < state.length; x++) {
        for (int y = 0; y < state[x].length; y++) {
          int left = x == 0 ? state.length - 1 : x - 1;
          int top = y == 0 ? state[x].length - 1 : y - 1;
          int right = x == state.length - 1 ? 0 : x + 1;
          int bottom = y == state[x].length - 1 ? 0 : y + 1;
          assert(0 <= left && left < 140);
          assert(0 <= right && right < 140);
          assert(0 <= top && top < 42);
          assert(0 <= bottom && bottom < 42);
//          print('$left $top $right $bottom');
          int sum = (state[left][top] ? 1 : 0) +
              (state[x][top] ? 1 : 0) +
              (state[right][top] ? 1 : 0) +
              (state[left][y] ? 1 : 0) +
              (state[right][y] ? 1 : 0) +
              (state[left][bottom] ? 1 : 0) +
              (state[x][bottom] ? 1 : 0) +
              (state[right][bottom] ? 1 : 0);
          if (sum == 3 || (sum == 2 && state[x][y])) {
            newState[x][y] = true;
          } else {
            newState[x][y] = false;
          }
        }
      }
      state = newState;
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    state = List.generate(140, (_) => List(42));
    for (int x = 0; x < state.length; x++) {
      for (int y = 0; y < state[x].length; y++) {
        state[x][y] = false;
      }
    }
    _handlePressed(Offset(30, 10));
  }

  _handlePressed(Offset offset) {
    setState(() {
      int x = offset.dx.round();
      int y = offset.dy.round();
      int left = x == 0 ? state.length - 1 : x - 1;
      int top = y == 0 ? state[x].length - 1 : y - 1;
      int right = x == state.length - 1 ? 0 : x + 1;
      int bottom = y == state[x].length - 1 ? 0 : y + 1;
      Random r = Random();
      int n = r.nextInt(10);
      if (n <= 6) {
        state[x][y] = true;
        state[left][y] = true;
        state[right][y] = true;
      } else if (n == 7) {
        state[x][y] = true;
        state[left][top] = true;
        state[x][bottom] = true;
        state[right][top] = true;
        state[right][y] = true;
      } else if (n == 8) {
        state[x][y] = true;
        state[left][top] = true;
        state[x][bottom] = true;
        state[right][top] = true;
        state[left][y] = true;
      } else if (n == 7) {
        state[x][y] = true;
        state[left][bottom] = true;
        state[x][top] = true;
        state[right][bottom] = true;
        state[right][y] = true;
      } else if (n == 8) {
        state[x][y] = true;
        state[left][bottom] = true;
        state[x][top] = true;
        state[right][bottom] = true;
        state[left][y] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnypixelBridge(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            CustomPaint(painter: GolPainter(toColorState())),
            Image.asset('assets/flutter.png'),
          ],
        ),
      ),
      onPressed: _handlePressed,
    );
  }

  List<List<Color>> toColorState() {
    List<Color> colors = [
      Colors.lightGreen,
      Colors.lightBlue,
      Colors.lightGreenAccent,
      Colors.lightBlueAccent,
    ];
    colors.shuffle();

    List<List<Color>> colorState = List.generate(140, (_) => List(42));
    for (int x = 0; x < state.length; x++) {
      for (int y = 0; y < state[x].length; y++) {
        colors.shuffle();
        colorState[x][y] = state[x][y] ? colors[0] : Colors.black;
      }
    }
    return colorState;
  }
}

class GolPainter extends CustomPainter {
  GolPainter(this.state);

  final List<List<Color>> state;

  @override
  void paint(Canvas canvas, Size size) {
    for (int x = 0; x < state.length; x++) {
      for (int y = 0; y < state[x].length; y++) {
        Offset offset = Offset(x.toDouble(), y.toDouble());
        canvas.drawRect(Rect.fromPoints(offset, offset + Offset(1, 1)),
            Paint()..color = state[x][y]);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
