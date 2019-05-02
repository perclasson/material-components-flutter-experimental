import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'hub_close.dart';

// Tested on 7" 1024x600
void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(FortnightlyHubClose());
}