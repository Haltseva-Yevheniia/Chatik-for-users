import 'package:chatik_for_users/services/authorization/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// constants to use through our project

//Colors

Color headTextColor = const Color(0xFFC282C4);

//styles
TextStyle headTextStyle = TextStyle(fontSize: 30, color: headTextColor, fontFamily: 'Montserrat', );

// objects

AuthService authService = AuthService();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;




