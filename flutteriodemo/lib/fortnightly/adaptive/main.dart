import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adaptive.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
//  SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(FortnightlyAdaptive());
}