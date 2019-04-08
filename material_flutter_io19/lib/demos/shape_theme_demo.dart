import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShapeThemeDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShapeThemeDemoState();
}

class ShapeThemeDemoState extends State<ShapeThemeDemo> {
  bool _isCut = false;

  @override
  Widget build(BuildContext context) {
    ThemeData _roundTheme = Theme.of(context).copyWith(
        cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ));

    ThemeData _cutTheme = Theme.of(context).copyWith(
        cardTheme: CardTheme(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ));

    return Theme(
      data: _isCut ? _cutTheme : _roundTheme,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Switch(
                value: _isCut,
                onChanged: (bool isCut) {
                  setState(() {
                    _isCut = isCut;
                  });
                },
              ),
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(child: Text('Shape')),
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(child: Text('Theme')),
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(child: Text('Demo')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
