// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utils.dart';
import '../counter_close/counter_close.dart';
import '../counter_far/counter_far.dart';

class FortnightlyProximity extends StatefulWidget {
  @override
  _FortnightlyProximityState createState() => _FortnightlyProximityState();
}

class _FortnightlyProximityState extends State<FortnightlyProximity> {
  dynamic _scanResults;
  CameraController _camera;
  bool _isDetecting = false;
  bool _isDisplayingClose = false;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    CameraDescription description = await getCamera(CameraLensDirection.front);

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
      if (_isDetecting || _isLocked) return;

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

  void _lockUpdates() {
    _isLocked = true;
    Timer(Duration(seconds: 2), () {
      _isLocked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add a fade between the 2 demos if possible.
    // TODO: Add a check for a face size if possible using the boundingBox.

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return FortnightlyCounterFar();
    }

    if (_scanResults is List<Face>) {
      List<Face> faces = _scanResults;
      if (faces.isNotEmpty) {
        // Prevent screen from flickering between states.
        if (!_isDisplayingClose) {
          _lockUpdates();
        }
        _isDisplayingClose = true;
        return FortnightlyCounterClose();
      }
    }

    // Prevent screen from flickering between states.
    if (_isDisplayingClose) {
      _lockUpdates();
    }
    _isDisplayingClose = false;
    return FortnightlyCounterFar();
  }
}
