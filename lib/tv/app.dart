import 'package:flutter/material.dart';
import 'package:tv_app/tv/widgets/app_layout.dart';

class TVApp extends StatelessWidget {
  const TVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        focusColor: Colors.blue,
        highlightColor: Colors.blue.withOpacity(0.3),
      ),
      home: const AppLayout(),
    );
  }
}
