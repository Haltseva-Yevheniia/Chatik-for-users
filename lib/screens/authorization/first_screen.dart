import 'package:chatik_for_users/screens/authorization/login_or_registration_screen.dart';
import 'package:chatik_for_users/screens/chat/list_chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: _firebaseAuth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            return const ListChats();
          } else {
            return const LogInOrRegistrationScreen();
          }
        } );
  }
}
