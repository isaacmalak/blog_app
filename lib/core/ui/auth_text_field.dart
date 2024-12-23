import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    this.onChanged,
    this.isPassword,
    required this.hintText,
    required this.controller,
  });
  final String hintText;
  final bool? isPassword;
  final Function(String)? onChanged;
  final TextEditingController controller;
  String? Function(String?)? validator() {
    return (value) {
      if (value!.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(hintText: hintText),
      validator: validator(),
    );
  }
}
