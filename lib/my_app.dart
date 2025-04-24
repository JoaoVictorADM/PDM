import 'package:flutter/material.dart';
import 'auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
