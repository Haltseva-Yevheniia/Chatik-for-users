import 'package:chatik_for_users/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage({required String receivedId, required String message}) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receivedId: receivedId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receivedId];

    ids.sort();

    String chatRoomId = ids.join("_");

    await _firebaseFirestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }


  Stream<QuerySnapshot> getMessage({required String userId, required String otherUserId}) {
    List<String> ids = [userId, otherUserId];

    ids.sort();

    String chatRoomId = ids.join('_');

    return _firebaseFirestore.collection('chat_room')
        .doc(chatRoomId).collection('messages')
        .orderBy('timestamp', descending: false,)
        .snapshots();
  }
}
