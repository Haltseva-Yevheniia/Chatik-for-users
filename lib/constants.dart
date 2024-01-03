import 'package:chatik_for_users/services/authorization/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// constants to use through our project

//Colors

Color headTextColor = const Color(0xFFB743BB);

//styles
TextStyle headTextStyle = TextStyle(fontSize: 30, color: headTextColor, fontFamily: 'Montserrat', fontWeight: FontWeight.w800);

// objects

AuthService authService = AuthService();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// users details

String currentUserEmail = firebaseAuth.currentUser!.email!;
String currentUserId = firebaseAuth.currentUser!.uid;
//var currentUserName= firebaseFirestore.collection('users').doc(currentUserId).snapshots()['name'];



