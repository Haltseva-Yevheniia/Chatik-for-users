import 'package:flutter/material.dart';

class UsersElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  const UsersElevatedButton ({super.key, required this.title, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton (
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shadowColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.0)),
          minimumSize: const Size (100, 50)),
        child: Text(
        title.toUpperCase(),
          style: const TextStyle(fontFamily: 'Monserrat'),
        ),
      ),
    );
  }
}
