import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';
class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: FirebaseFirestore.instance.collection('/chat').orderBy('date',descending: true).snapshots(),
        builder: (ctx,streamSnapshot) {
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(streamSnapshot.hasData){
            var docs=streamSnapshot.data.docs;
            return ListView.builder(
              reverse: true,
                itemCount: docs.length,
                itemBuilder: (ctx,index){
                  return  Bubble(
                      message:docs[index]['text'],
                    dateTime: docs[index]['date'].toDate(),
                    uid: docs[index]['uid'],
                  );
                }
            );
          }
          else{
            return const Text("OOPS");
          }
        }
    );
  }
}
