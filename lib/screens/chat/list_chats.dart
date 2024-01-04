import 'dart:io';

import 'package:chatik_for_users/constants.dart';
import 'package:chatik_for_users/screens/chat/chat_room.dart';
import 'package:chatik_for_users/services/profile/profile_service.dart';
import 'package:chatik_for_users/widgets/users_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ListChats extends StatefulWidget {
  const ListChats({super.key});

  @override
  State<ListChats> createState() => _ListChatsState();
}

class _ListChatsState extends State<ListChats> {
  File? userAvatar;
  ProfileService profileService = ProfileService();

  Future<String?> getCurrentName() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final currentId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot currentUser =
    await firebaseFirestore.collection('users').doc(currentId).get();
    String currentUserName = currentUser['name'];
    return currentUserName;
  }

  late Future<String?> currentName;

  Future<void> addName(String name) async {
    await profileService.addName(name: name);
  }

  Future<void> addAvatarToBase (File avatar) async{
    await profileService.addAvatar(avatar: avatar);
  }

  void showDialogToEnterName() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController nameController = TextEditingController();
          return AlertDialog(
            title: const Text('Add or edit name'),
            content: UsersTextField(
              label: 'Name',
              hintText: 'Add your name',
              controller: nameController,
              //onChanged: ,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    addName(nameController.text);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  Future<void> addAvatarFromGallery() async {
    final selectedAvatar =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedAvatar == null) return;
    setState(() {
      userAvatar = File(selectedAvatar.path);
    });
  }

  @override
  void initState() {
    super.initState();
    currentName = getCurrentName();
    // getCurrentName().then((String value) {
    //   setState(() {
    //     currentName = value;
    //
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                'My profile'.toUpperCase(),
                textAlign: TextAlign.center,
                style: headTextStyle,
              ),
              CircleAvatar(
                child: userAvatar != null ? Image.file(userAvatar!) : null,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    addAvatarFromGallery();
                    if (userAvatar!=null)
                    {addAvatarToBase(userAvatar!);}
                  });

                },
                child: const Text('Change photo'),
              ),
              Row(
                children: [
                  FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(currentUserId).get(),
                      builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else if (snapshot.data!['name'] == null) {
                      return const Text('Name: no name');
                    } else {
                      return Text('Name: ${snapshot.data!['name']}');
                    }
                  }),
                  // currentName != null ? Text('Name: $currentName') : const Text(
                  //     'Name: no name'),

                  TextButton(
                    onPressed: () {
                      showDialogToEnterName();

                    },
                    child: const Text('Add/edite name'),
                  ),
                ],
              ),
              Text('Email: $currentUserEmail'),
              const SizedBox(
                height: 50,
              ),
              IconButton(
                onPressed: () => authService.logOut(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Chatiks'),
        centerTitle: true,
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
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data == null) {
          return const Text('No data');
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
                        builder: (context) =>
                            ChatRoom(
                              receivedUserEmail: user['email'],
                              receivedUserId: user['uid'],
                              recievedUserName: user['name'],
                            ),
                      ),
                    );
                  },
                  leading: const CircleAvatar(),
                  title: (user['name'] != null)
                      ? Text(user['name'])
                      : Text(user['email']),
                  subtitle: (user['name'] == null) ? null : Text(user['email']),
                  trailing: const Icon(Icons.arrow_forward_ios_sharp),
                );
              });
        }
      },
    );
  }
}
