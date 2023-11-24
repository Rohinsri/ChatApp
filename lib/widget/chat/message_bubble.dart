import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Bubble extends StatefulWidget {
  const Bubble(
      {
        Key? key,
        required this.message,
        required this.dateTime,
        required this.uid
      }
      ) : super(key: key);
  final String message;
  final DateTime dateTime;
  final String uid;

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  var id=FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: id==widget.uid?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width*0.6,
            ),
            decoration: BoxDecoration(
              color: id==widget.uid?Colors.greenAccent:Colors.blue[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),
                ),
                const SizedBox(width: 10,),
                Text(DateFormat('HH:mm').format(widget.dateTime).toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
