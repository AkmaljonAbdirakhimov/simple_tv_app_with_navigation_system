import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tv/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for TV
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const TVApp());
}
