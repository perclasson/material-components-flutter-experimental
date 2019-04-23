import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../anypixel.dart';

class AnypixelHeightDemo extends StatefulWidget {
  @override
  AnypixelHeightDemoState createState() => AnypixelHeightDemoState();
}

class AnypixelHeightDemoState extends State<AnypixelHeightDemo> {
  double containerHeight = 0;
  double x = 0;
  double y = 42;
  double opacity = 0;

  _handlePressed(Offset offset) {
    setState(() {
      x = offset.dx;
      y = offset.dy;
      opacity = 1;
    });
  }

  @override
  void initState() {
    super.initState();
//    _handlePressed(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    double left = x;
    double right = 140 - x - 20;
    double top = y;
    int heightInches = 36 + 2 * (42 - y.round());
    String heightText = '${heightInches ~/ 12}\'${heightInches % 12}';

    return AnypixelBridge(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.only(left: left, top: top, right: right),
              color: Colors.blue,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.only(left: left, top: top, right: right),
              child: Text(
                heightText,
                style: Theme.of(context).textTheme.headline.copyWith(
                      fontSize: 10,
                      color: Colors.white,
                    ),
              ),
            )
          ],
        ),
      ),
      onPressed: _handlePressed,
    );

    return GestureDetector(
      onTap: () => _handlePressed(Offset.zero),
      child: Center(
        child: Container(
          color: Colors.red,
          width: 140,
          height: 42,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 2000),
            margin: EdgeInsets.only(left: left, top: top, right: right),
            color: Colors.green,
//              width: 10,
//            height: containerHeight,
          ),
        ),
      ),
    );
  }
}
