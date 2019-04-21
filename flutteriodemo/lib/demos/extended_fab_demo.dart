import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExtendedFabDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExtendedFabDemoState();
}

class ExtendedFabDemoState extends State<ExtendedFabDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: Builder(builder: (BuildContext context) {
        // define context of Navigator.push()
        return FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('I will resize when tapped'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  floatingActionButton: new FloatingActionButton.extended(
                    icon: const Icon(Icons.add),
                    label: const Text('Cool'),
                    onPressed: () {},
                  ),
                  body: new Center(
                    child: new RaisedButton(
                      child: const Text('Back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ));
          },
        );
      }),
      body: const Center(
        child: const Text('Tap the FAB'),
      ),
    );
  }
}
