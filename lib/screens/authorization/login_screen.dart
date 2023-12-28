import 'package:chatik_for_users/services/authorization/auth_service.dart';
import 'package:chatik_for_users/widgets/users_elevated_button.dart';
import 'package:chatik_for_users/widgets/users_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import '../../widgets/users_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  signIn() {}

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn() async {
    try {
      await _authService.signInWithEmail(email: emailController.text, password: passwordController.text);
      catch (error){
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFDEEAE7),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login Page'),
        titleTextStyle: const TextStyle(fontFamily: 'Montserrat'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset('assets/animation/snowman.json',
            height: 250,
            width: 180),
            Text(
              'Log in'.toUpperCase(),
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                color: Colors.purple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            UsersTextField(
              controller: emailController,
              label: 'E-mail',
              hintText: 'Enter your email',
            ),
            const SizedBox(height: 15),
            UsersTextField(
              controller: passwordController,
              label: 'Password',
              hintText: 'Enter your password',
            ),
            const SizedBox(height: 30,),
            UsersElevatedButton(
              title: 'Sign In'.toUpperCase(),
              onPressed: () => signIn(),
            ),
          ],
        ),
      ),
    );
  }
}
