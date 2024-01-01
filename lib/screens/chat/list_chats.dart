import 'package:chatik_for_users/constants.dart';
import 'package:flutter/material.dart';
class ListChats extends StatelessWidget {
  const ListChats({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatiks'),
        actions: [
          IconButton(onPressed: () => authService.logOut(), icon: Icon(Icons.logout),),
        ],
      ),
    );
  }
}

