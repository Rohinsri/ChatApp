import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/chat_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (ctx,streamSnapshot){
          if(streamSnapshot.hasData) {
            return const UserScreen();
          }
          else{
            return const LoginScreen();
          }
        }
        ),
    );
  }
}