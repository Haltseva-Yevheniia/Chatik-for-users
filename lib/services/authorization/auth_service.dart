//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
    String? name,
    Image? avatar,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
      //   {
      //     'uid': userCredential.user!.uid,
      //     'email': email,
      //     'name': name ?? name,
      //     'avatar': avatar ?? avatar,
      //   },
      //   SetOptions(merge: true,),
      // );

      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.message);
    }
  }

  Future<UserCredential> registrUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
