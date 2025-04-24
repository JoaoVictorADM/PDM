import 'package:chat/sign_in_screen.dart';
import 'package:chat/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignin = true;

  void toggleForm() {
    setState(() {
      _isSignin = !_isSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 1, 25, 77),
              Color.fromARGB(255, 1, 8, 24),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child:
                _isSignin
                    ? SignInScreen(
                      onToggleForm: toggleForm,
                      key: const ValueKey('signin'),
                    )
                    : SignUpScreen(
                      onToggleForm: toggleForm,
                      key: const ValueKey('signup'),
                    ),
          ),
        ),
      ),
    );
  }
}
