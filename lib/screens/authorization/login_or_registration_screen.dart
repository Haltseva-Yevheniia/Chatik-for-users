import 'package:chatik_for_users/screens/authorization/login_screen.dart';
import 'package:chatik_for_users/screens/authorization/registration_screen.dart';
import 'package:flutter/material.dart';

class LogInOrRegistrationScreen extends StatefulWidget {
  const LogInOrRegistrationScreen({super.key});

  @override
  State<LogInOrRegistrationScreen> createState() => _LogInOrRegistrationScreenState();
}

class _LogInOrRegistrationScreenState extends State<LogInOrRegistrationScreen> {
  bool isLogedIn = true;

  void switchedScreens (){
    setState(() {
      isLogedIn = !isLogedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogedIn ? const LoginScreen() : const RegistrationScreen();
    //TODO Evgeniya Animation transfer between the screens
  }
}
