import 'package:flutter/material.dart';
import 'package:get_screenshot/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(backgroundColor: Colors.purpleAccent, elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}
