import 'package:chatik_for_users/screens/authorization/registration_screen.dart';
import 'package:chatik_for_users/services/authorization/auth_service.dart';
import 'package:chatik_for_users/widgets/users_elevated_button.dart';
import 'package:chatik_for_users/widgets/users_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import '../../widgets/users_elevated_button.dart';

class LoginScreen extends StatefulWidget {


  final Function()? switchedMethod;
  const LoginScreen({super.key, required this.switchedMethod});
  //signIn() {}

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn(context) async {
    try {
      await _authService.signInWithEmail(
          email: emailController.text, password: passwordController.text);
    } catch (error) {
      showError(error.toString(), context);
    }
  }

  void showError(String error, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFDEEAE7),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login Page'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset('assets/animation/snowman.json',
                    height: 200, width: 150),
                Text(
                  'Log in'.toUpperCase(),
                  style: headTextStyle,
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
                const SizedBox(
                  height: 30,
                ),
                UsersElevatedButton(
                  title: 'Sign In'.toUpperCase(),
                  onPressed: () => signIn(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      " Don't have an account?",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    TextButton(
                      onPressed: widget.switchedMethod,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
