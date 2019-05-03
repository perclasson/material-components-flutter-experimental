import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adaptive.dart';

void main(List<String> args) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  return runApp(FortnightlyAdaptive());
}