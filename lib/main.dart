import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';

void main() {
  runApp(const SQFLiteApp());
}

class SQFLiteApp extends StatelessWidget {
  const SQFLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFLite App',
      home: HomeScreen(),
    );
  }
}
