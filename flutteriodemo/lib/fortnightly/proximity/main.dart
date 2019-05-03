// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'proximity.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(FortnightlyProximity());
}