import 'package:flutter/material.dart';
import 'package:sorting_visualizer/screens/sizeInput.dart';
import 'screens/welcomeScreen.dart';

void main() => runApp(SortingVisualizer());

class SortingVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
