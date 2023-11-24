import 'dart:ui';

import 'package:flutter/material.dart';
import '../widget/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth= FirebaseAuth.instance;
  void _submitAuth(
      String email,
      String username,
      String password,
      bool isLogin,
      BuildContext ctx,
      ) async{
    UserCredential authResult;
    try{
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else{
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseFirestore.instance.collection('users').doc(authResult.user?.uid).set({
          'email':email,
          'username':username
        });
      }
    }on FirebaseAuthException catch(err){
      String message=err.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor
        )
      );
    }
    catch(err){
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Card(
            color: Colors.grey.shade200.withOpacity(0.4),
            margin: kIsWeb?
            EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width*0.32,
                0,
                MediaQuery.of(context).size.width*0.32,
                0):
            const EdgeInsets.all(40),
            elevation: 40,
            shadowColor: Colors.black,
            child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: LoginForm(submit:_submitAuth),
              ),
            ),
          ),
        ),
      ),
    );
  }
}