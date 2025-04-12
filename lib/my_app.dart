import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'create_acount.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
