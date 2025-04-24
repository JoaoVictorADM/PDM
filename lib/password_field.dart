import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const PasswordField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PassawordFieldState();
}

class _PassawordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: _toggleVisibility,
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: widget.validator,
    );
  }
}
