// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utils.dart';
import '../hub_close/hub_close.dart';
import '../hub_far/hub_far.dart';

class FortnightlyProximity extends StatefulWidget {
  @override
  _FortnightlyProximityState createState() => _FortnightlyProximityState();
}

class _FortnightlyProximityState extends State<FortnightlyProximity> {
  dynamic _scanResults;
  CameraController _camera;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    CameraDescription description = await getCamera(_direction);

    setState(() {
      _camera = CameraController(
        description,
        defaultTargetPlatform == TargetPlatform.iOS
            ? ResolutionPreset.low
            : ResolutionPreset.medium,
      );
    });

    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      detect(image, FirebaseVision.instance.faceDetector().processImage).then(
            (dynamic result) {
          setState(() {
            _scanResults = result;
          });

          _isDetecting = false;
        },
      ).catchError(
            (_) {
          _isDetecting = false;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Since the detection is a little buggy, prevent the demo from changing by using a timer.
    // TODO: Add a fade between the 2 demos if possible.
    // TODO: Add a check for a face size if possible.
    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return FortnightlyHubFar();
    }

    if (_scanResults is List<Face>) {
      List<Face> faces = _scanResults;
      if (faces.isNotEmpty) {
        return FortnightlyHubClose();
      }
    }

    return FortnightlyHubFar();
  }
}
