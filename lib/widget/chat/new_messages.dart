import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var enteredMessage="";
  final TextEditingController _controller = TextEditingController();
  void submit(){
    if(!kIsWeb){
      Focus.of(context).unfocus();
    }
    _controller.clear();
    FirebaseFirestore.instance.collection('chat').add({
      'text':enteredMessage,
      'date':DateTime.now(),
      'uid' :FirebaseAuth.instance.currentUser?.uid,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top:10),
      color: Colors.blue[100],
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value){
                  setState(() {
                    enteredMessage=value;
                  });
                },
              )
          ),
          TextButton(
            onPressed: enteredMessage.trim().isEmpty?null:submit,
            child: const Icon(
              Icons.message
            ),
          )
        ],
      )
    );
  }
}