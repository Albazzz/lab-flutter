import 'package:flutter/material.dart';
import 'login_page.dart';
import 'list_items_page.dart';
import 'testing_page.dart';
import 'group_list_page.dart';
import 'advanced_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    //
      home: const AdvancedLoginPage(),
    );
  }
}
