import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AnypixelDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnypixelDemoState();
}

class AnypixelDemoState extends State<AnypixelDemo> {
  @override
  Widget build(BuildContext context) {
    Row row1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.fastfood),
        Text('Yum!'),
        Icon(Icons.cake),
        Text('Mmmm!'),
      ],
    );
    Row row2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.book),
        Icon(Icons.flag),
        Icon(Icons.book),
        Icon(Icons.flag),
      ],
    );
    Row textRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Neat!'),
        Icon(Icons.flight),
        Text('Cool!'),
        Icon(Icons.directions_car),
      ],
    );
    List<Row> iconRows = [
      row1,
      row2,
      textRow,
      row1,
      row2,
      textRow,
      row1,
      row2,
      textRow,
      row1,
      row2,
      textRow,
      row1,
      row2,
    ];

    return Scaffold(
      body: SafeArea(
        child: AnypixelBridge(
          child: ListView(
            children: iconRows,
          ),
        ),
      ),
    );
  }
}

class AnypixelBridge extends StatefulWidget {
  AnypixelBridge({this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => AnypixelBridgeState();
}

class AnypixelBridgeState extends State<AnypixelBridge>
    with SingleTickerProviderStateMixin {
  GlobalKey globalKey = GlobalKey();
  Ticker _ticker;

  @override
  void initState() {
    print('initState');
    super.initState();
    _ticker = this.createTicker((Duration duration) {
      setState(() {});
    });
    _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _captureImage(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        return Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 64),
              SizedBox(
                width: 140,
                height: 42,
                child: RepaintBoundary(
                  child: widget.child,
                  key: globalKey,
                ),
              ),
              SizedBox(height: 64),
              RawImage(image: _project(snapshot.data)),
            ],
          ),
        );
      },
    );
  }

  Future<ui.Image> _captureImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 1);

    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    Uint8List imageBytes = byteData.buffer.asUint8List();

    // TODO(clocksmith): better rbga => rbg
    List<int> noAlphaBytes = [0];
    for (int i = 0; i < imageBytes.length; i++) {
      if (i % 4 != 0) {
        noAlphaBytes.add(imageBytes[i]);
      }
    }

    var body = new Map<String, dynamic>();
    body['arr'] = noAlphaBytes.toString();

//    print(noAlphaBytes.length);

    // 10.0.2.2 for android
    http.post('http://127.0.0.1:8000/flutter/publish-view', body: body);
    http.get('http://127.0.0.1:8000/flutter/read-tap').then((Response val) {
      List<dynamic> arr = jsonDecode(val.body);
      if (arr.length == 4 && arr[3] == 1) {
        print('x: ${arr[2]}, y: ${arr[1]}');
      }
//      boundary.hitTest(result, position: null)
    });

    return image;
  }

  ui.Image _project(ui.Image source) {
    return source;
  }
}
