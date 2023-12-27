import 'package:flutter/material.dart';

class UsersTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Icon? icon;
  final bool obscured;

  const UsersTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.icon,
    this.obscured = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
       obscureText: obscured,
      decoration: InputDecoration(
        prefixIcon: icon ?? const SizedBox.shrink(),
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'Montserrat'),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.indigo,
          ),
        ),
        fillColor: Colors.indigo.withOpacity(0.2),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.purple,
          ),
        ),
        focusColor: Colors.transparent,
      ),
    );
  }
}
