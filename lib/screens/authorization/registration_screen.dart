import 'package:chatik_for_users/constants.dart';
import 'package:chatik_for_users/services/authorization/auth_service.dart';
import 'package:chatik_for_users/widgets/users_elevated_button.dart';
import 'package:chatik_for_users/widgets/users_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final Function()? switchedMethod;

  const RegistrationScreen({super.key, required this.switchedMethod});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  AuthService authService = AuthService();

  Future<void> registrUp() async {
    try {
      await authService.registrUp(
          email: emailController.text, password: passwordController.text);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration screen'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Fill in the form',
                style: headTextStyle,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            UsersTextField(
              controller: emailController,
              label: 'Email',
              hintText: 'Enter email',
            ),
            const SizedBox(
              height: 30,
            ),
            UsersTextField(
              controller: passwordController,
              label: 'Password',
              hintText: 'Enter password',
              obscured: true,
            ),
            const SizedBox(
              height: 30,
            ),
            UsersTextField(
              controller: passwordConfirmController,
              label: 'Confirm password',
              hintText: 'Confirm your password',
            ),
            const SizedBox(
              height: 30,
            ),
            UsersElevatedButton(
                title: 'Registration'.toUpperCase(), onPressed: registrUp),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('If you are registrated, please'),
                TextButton(
                  onPressed: widget.switchedMethod,
                  child: const Text('Log in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
