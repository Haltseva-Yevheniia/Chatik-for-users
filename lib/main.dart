import 'package:chatik_for_users/firebase_options.dart';
import 'package:chatik_for_users/screens/authorization/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // At first to ensure that the initialisation of our Flutter engine is done
  WidgetsFlutterBinding.ensureInitialized();
  // Then to initialise our firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatikApp());
}

class ChatikApp extends StatelessWidget {
  const ChatikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
