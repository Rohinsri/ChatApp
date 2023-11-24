import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/chat/messages.dart';
import '../widget/chat/new_messages.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Chat"),
        actions:  [
          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
          },
            icon:const Icon(Icons.logout),)
        ],
      ),
      body: Column(
        children: const [
          Expanded(
              child: Messages()
          ),
          NewMessages()
        ],
      ),
    );
  }
}
