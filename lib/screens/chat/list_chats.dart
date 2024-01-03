import 'package:chatik_for_users/constants.dart';
import 'package:chatik_for_users/screens/chat/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListChats extends StatelessWidget {
  const ListChats({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    // final currentId = FirebaseAuth.instance.currentUser!.uid;
    // var currentUser= _firebaseFirestore.collection('users').doc(currentId);
    // String currentUserName = currentUser['name'];

    void addName() {}

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Text(
              'My profile'.toUpperCase(),
              textAlign: TextAlign.center,
              style: headTextStyle,
            ),
            CircleAvatar(),
            TextButton(onPressed: () {}, child: Text('Change photo')),
            Row(
              children: [
                Text('Name: '),
                TextButton(
                  onPressed: () {},
                  child: Text('Add/edite name'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Email: $currentUserEmail'),
                TextButton(
                  onPressed: () {},
                  child: Text('Add/edite email'),
                ),
              ],
            ),
            IconButton(
              onPressed: () => authService.logOut(),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
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

  // Widget _createListOfUsers() {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: firebaseFirestore.collection('users').snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return Text('Error'.toUpperCase());
  //         } else if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else if (snapshot.data == null) {
  //           return Text('No data');
  //         } else {
  //           return ListView.builder(
  //             itemCount: snapshot.data!.docs.length,
  //             itemBuilder: (context, index) {
  //               final user = snapshot.data!.docs[index];
  //               return ListTile(
  //                 leading: CircleAvatar(),
  //                 //   if (user['avatar']!= null) { return CircleAvatar(
  //                 //   backgroundImage: user['avatar'],
  //                 // );},
  //                 title: Text(user['name']),
  //                 //     if (user['name']!=null)
  //                 // {
  //                 //   return Text(user['name']);
  //                 // } else {
  //                 //     return Text ('No name');},
  //                 subtitle: Text(user['email']),
  //                 trailing: Icon(Icons.keyboard_double_arrow_right),
  //                 onTap: () {
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) => ChatRoom()));
  //                 },
  //               );
  //             },
  //           );
  //         }
  //       });
  // }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data == null) {
          return Text('No data');
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final user = snapshot.data!.docs[index];

                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatRoom(
                                  receivedUserEmail: user['email'],
                                  receivedUserId: user['uid'],
                                )));
                  },
                  leading: const CircleAvatar(),
                  title: Text(user['email']),
                  subtitle: (user['name'] != null)
                      ? Text(user['name'])
                      : Text('No name'),
                  trailing: const Icon(Icons.arrow_forward_ios_sharp),
                );
              });
        }
      },
    );
  }
}
