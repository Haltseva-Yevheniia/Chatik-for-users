import 'package:flutter/material.dart';

void main() {
  runApp(const ChatikApp());
}

class ChatikApp extends StatelessWidget {
  const ChatikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
