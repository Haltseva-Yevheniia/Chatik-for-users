import 'package:chatik_for_users/screens/authorization/login_screen.dart';
import 'package:chatik_for_users/screens/authorization/registration_screen.dart';
import 'package:flutter/material.dart';

class LogInOrRegistrationScreen extends StatefulWidget {
  const LogInOrRegistrationScreen({super.key});

  @override
  State<LogInOrRegistrationScreen> createState() =>
      _LogInOrRegistrationScreenState();
}

class _LogInOrRegistrationScreenState extends State<LogInOrRegistrationScreen> {
  bool isLogedIn = true;

  void switchScreens() {
    setState(() {
      isLogedIn = !isLogedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return isLogedIn ? LoginScreen(switchedMethod: switchScreens) : RegistrationScreen(switchedMethod: switchScreens);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: isLogedIn
          ? LoginScreen(switchedMethod: switchScreens)
          : RegistrationScreen(switchedMethod: switchScreens),
    );
  }
}
