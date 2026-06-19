import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool loggedIn = await AuthService.isLoggedIn();
  runApp(TodoApp(isLoggedIn: loggedIn));
}

class TodoApp extends StatelessWidget {
  final bool isLoggedIn;
  const TodoApp({super.key, required this.isLoggedIn});

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
        fontFamily: '.SF Pro Text',
      ),
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
