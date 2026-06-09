import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Todo Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppleColors.primary,
          primary: AppleColors.primary,
        ),
        useMaterial3: true,
        fontFamily: '.SF Pro Text', // System font for Apple feel
      ),
      home: const HomeScreen(),
    );
  }
}
