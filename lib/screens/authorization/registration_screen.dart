import 'package:chatik_for_users/constants.dart';
import 'package:chatik_for_users/services/authorization/auth_service.dart';
import 'package:chatik_for_users/widgets/users_elevated_button.dart';
import 'package:chatik_for_users/widgets/users_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  //Image? avatar;
  AuthService authService = AuthService();

  Future<void> registrUp() async {
    try {
      await authService.registrUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );
    } catch (error) {
      throw Exception(error);
    }
  }
  void showAlertPassword(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Try reconfirm the password'),

            actions: [
              ElevatedButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
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
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset('assets/animation/snowman.json',
                    height: 150, width: 150),
                Center(
                  child: Text(
                    'Fill in the form',
                    style: headTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            UsersTextField(
              controller: nameController,
              label: 'Name',
              hintText: 'Enter your name',
            ),
            const SizedBox(
              height: 20,
            ),
            UsersTextField(
              controller: emailController,
              label: 'Email',
              hintText: 'Enter email',
            ),
            const SizedBox(
              height: 15,
            ),
            UsersTextField(
              controller: passwordController,
              label: 'Password',
              hintText: 'Enter password',
              obscured: true,
            ),
            const SizedBox(
              height: 15,
            ),
            UsersTextField(
              controller: passwordConfirmController,
              label: 'Confirm password',
              hintText: 'Confirm your password',
              obscured: true,
            ),
            const SizedBox(
              height: 30,
            ),
            UsersElevatedButton(
                title: 'Registration'.toUpperCase(), onPressed: (){
                  if (passwordController.text==passwordConfirmController.text) {
                  registrUp();} else {
                    showAlertPassword(context);
                  }
            }),
            const SizedBox(
              height: 10,
            ),
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
