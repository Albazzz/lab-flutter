import 'package:flutter/material.dart';
import 'views/genre_screen.dart';
import 'theme/apple_design.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Movie Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppleDesign.canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppleDesign.primary,
          primary: AppleDesign.primary,
        ),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}
