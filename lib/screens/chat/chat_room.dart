import 'package:chatik_for_users/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final String receivedUserId;
  final String receivedUserEmail;
  final String? recievedUserName;
  const ChatRoom({super.key, this.recievedUserName, required this.receivedUserId, required this.receivedUserEmail});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  void sendMessage() async {
    await _chatService.sendMessage(
        receivedId: widget.receivedUserId, message: messageController.text);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: (widget.recievedUserName==null)? Text(widget.receivedUserEmail) : Text(widget.recievedUserName!),
     ),
      body: Column(
        children: [
          Expanded (child: _buildMessageList()),
          _buildInput(),
      ],
    ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(stream: _chatService.getMessage(
        userId: _firebaseAuth.currentUser!.uid,
        otherUserId: widget.receivedUserId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  bool isCurrentUser = _firebaseAuth.currentUser!.uid == snapshot.data!.docs[index]['senderId'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Colors.green[900] : Colors.purpleAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10),
                              topLeft: Radius.circular(isCurrentUser ? 10 : 0),
                              topRight: Radius.circular(isCurrentUser ? 0 :10),
                            )
                          ),
                          child: Text(snapshot.data!.docs[index]['message']),
                        ),
                        //TODO add time in String format
                        //Text(snapshot.data!.docs[index]['timestamp'].toString()),
                      ],
                    ),
                  );
                });
              }
    });
  }

  Widget _buildInput(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row (
        children: [
          Expanded(
           child: TextField(
          controller: messageController,
             decoration: const InputDecoration(
               border: OutlineInputBorder()
             ),
            ),
          ),
            IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }


}
