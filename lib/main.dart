import 'package:animatedlogin/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated login',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

