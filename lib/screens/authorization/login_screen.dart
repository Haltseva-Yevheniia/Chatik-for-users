import 'package:flutter/material.dart';
// import '../../widgets/users_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('Login Page'),
        titleTextStyle: const TextStyle(fontFamily: 'Monserrat'),
      ),
    );
  }
}
