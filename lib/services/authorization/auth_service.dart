import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': userCredential.user!.email,
          }, SetOptions(merge: true),);


      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.message);
    }
  }

  Future<UserCredential> registrUp({
    required String email,
    required String password,
    String? name,
    Image? avatar,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'avatar': avatar,

        });
    return userCredential;
  }

  Future<void> logOut () async {
    await _firebaseAuth.signOut();
  }
}
