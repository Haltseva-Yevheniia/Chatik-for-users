import 'package:chatik_for_users/widgets/users_elevated_button.dart';
import 'package:chatik_for_users/widgets/users_textfield.dart';
import 'package:flutter/material.dart';
// import '../../widgets/users_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  signIn() {}

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEEAE7),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login Page'),
        titleTextStyle: const TextStyle(fontFamily: 'Monserrat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UsersTextField(
            controller: emailController,
            label: 'E-mail',
            hintText: 'Enter your email',
          ),
          UsersTextField(
            controller: passwordController,
            label: 'Password',
            hintText: 'Enter your password',
          ),
          UsersElevatedButton(
            title: 'Sign In'.toUpperCase(),
            onPressed: () => signIn(),
          ),
        ],
      ),
    );
  }
}
