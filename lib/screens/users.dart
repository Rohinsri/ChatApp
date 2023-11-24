import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: StreamBuilder<dynamic>(
        stream: FirebaseFirestore.instance.collection('/users').snapshots(),
        builder: (ctx,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData){
            var docs=snapshot.data.docs;
            return ListView.builder(
                itemBuilder: (ctx,index){
                  return  ListTile(
                    title: Text(docs.username.toString())
                  );
                }
            );
          }
          else{
            return const Text("OOPS");
          }
        }
      ),
    );
  }
}
