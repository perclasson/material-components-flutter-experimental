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
        Icon(Icons.fastfood, color: Colors.orange,),
        Text('Yum!'),
        Icon(Icons.cake, color: Colors.lightGreen,),
        Text('Mmmm!'),
      ],
    );
    Row row2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Just text...', style: Theme.of(context).primaryTextTheme.headline),
      ],
    );
    Row row3 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Neat!'),
        Icon(Icons.flight, color: Colors.cyan,),
        Text('Cool!'),
        Icon(Icons.directions_car, color: Colors.pink,),
      ],
    );
//    List<Row> children = [
//      row1,
//      row2,
//      row3,
//      row1,
//      row2,
//      row3,
//      row1,
//      row2,
//      row3,
//    ];
    TextStyle style = Theme.of(context).primaryTextTheme.headline.copyWith(
      fontSize: 12,
      letterSpacing: 1
    );
    List<Widget> children = [
      SizedBox(
        width: 140,
        child: Center(child: Text('The Quiet, Yet Powerful Healthcare Revolution', style: style, textAlign: TextAlign.center,)),
      ),
      SizedBox(
        width: 140,
        child: Center(child: Text('As Stocks Stagnate, Many Look to Currency', style: style, textAlign: TextAlign.center)),
      ),
      SizedBox(
        width: 140,
        child: Center(child: Text('Llamas Patrol the Central Coast of California', style: style, textAlign: TextAlign.center)),
      ),
    ];

    ScrollController _scrollController = ScrollController();

    return Scaffold(
      body: SafeArea(
        child: AnypixelBridge(
          child: Container(
            color: Colors.black,
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              children: children,
            ),
          ),
          onPressed: (Offset offset) {
            print(offset.toString());
            _scrollController.position.animateTo(
              _scrollController.offset + (offset.dx > 70 ? 140 : -140),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}

class AnypixelBridge extends StatefulWidget {
  AnypixelBridge({this.child, this.onPressed});

  final Widget child;
  final ValueChanged<Offset> onPressed;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              SizedBox(height: 64),
              SizedBox(
                width: 140,
                height: 42,
                child: RepaintBoundary(
                  child: widget.child,
                  key: globalKey,
                ),
              ),
//              SizedBox(height: 64),
//              RawImage(image: _project(snapshot.data)),
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
      if ((i + 1) % 4 != 0) {
        noAlphaBytes.add(imageBytes[i]);
      }
    }
//    print(noAlphaBytes.toString());

    var body = new Map<String, dynamic>();
    body['arr'] = noAlphaBytes.toString();

//    print(noAlphaBytes.length);

    // 10.0.2.2 for android
    http.post('http://127.0.0.1:8000/flutter/publish-view', body: body);
    http.get('http://127.0.0.1:8000/flutter/read-tap').then((Response val) {
      List<dynamic> arr = jsonDecode(val.body);
      if (arr.length == 4 && arr[3] == 1) {
        widget.onPressed(Offset(arr[2].toDouble(), arr[1].toDouble()));
      }
//      boundary.hitTest(result, position: null)
    });

    return image;
  }

  ui.Image _project(ui.Image source) {
    return source;
  }
}
