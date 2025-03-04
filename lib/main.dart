import 'package:flutter/material.dart';

import 'widgets/app_layout.dart';
import 'widgets/tv_focusable.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TVFocusableApp(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const AppLayout(),
      ),
    );
  }
}
