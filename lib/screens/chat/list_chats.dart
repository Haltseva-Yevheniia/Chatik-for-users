//import 'dart:js';
import 'package:chatik_for_users/constants.dart';
import 'package:chatik_for_users/screens/chat/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListChats extends StatelessWidget {
  const ListChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatiks'),
        actions: [
          IconButton(
            onPressed: () => authService.logOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final user = snapshot.data!.docs[index];
                return ListTile(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ChatRoom(
                      receivedUserEmail: user['email'],
                      receivedUserId: user ['uid'],
                    ))
                    );
                  },
                  leading: const CircleAvatar(),
                  title: Text (user['email']),
                  trailing: const Icon(Icons.arrow_forward_ios_sharp),
                );
              });
        }
      },
    );
  }
}
