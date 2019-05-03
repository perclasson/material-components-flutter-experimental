// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utils.dart';
import '../hub_close/hub_close.dart';
import '../hub_far/hub_far.dart';

// Adjust this number to work for the demo.
const double _proximityThreshold = 0.1;

// Set this to true to ignore any face size math and simply use the presence
// of a face as the deciding factor.
const bool _forceForAnySizeFace = false;

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
        ResolutionPreset.low,
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

  bool _isCloseExperience() {
    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return false;
    }

    if (_scanResults is List<Face>) {
      List<Face> faces = _scanResults;
      if (faces.isNotEmpty && _forceForAnySizeFace) {
        return true;
      }

      final Size imageSize = Size(
        _camera.value.previewSize.height,
        _camera.value.previewSize.width,
      );
      final double imageArea = imageSize.width * imageSize.height;

      for (Face face in faces) {
        final double faceArea = face.boundingBox.width * face.boundingBox.height;
        // Only display the close experience when the face is at least `_proximityThreshold` of the visible space.
        if (faceArea >= imageArea * _proximityThreshold) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add a fade between the 2 demos if possible.
    Widget fortnightly;
    if (_isCloseExperience()) {
      if (!_isDisplayingClose) {
        _lockUpdates();
      }
      _isDisplayingClose = true;
      fortnightly = FortnightlyHubClose();
    } else {
      // Prevent screen from flickering between states.
      if (_isDisplayingClose) {
        _lockUpdates();
      }
      _isDisplayingClose = false;
      fortnightly = FortnightlyHubFar();
    }

    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        fortnightly,
        if (_camera != null)
          Positioned(
            right: 12,
            width: 200,
            bottom: 12,
            height: 200,
            child: Transform.rotate(
              angle: -math.pi / 2,
              child: CameraPreview(_camera),
            ),
          ),
      ],
    );
  }
}
