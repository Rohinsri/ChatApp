import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.submit}) : super(key: key);
  final void Function (
      String email,
      String username,
      String password,
      bool isLogin,
      BuildContext ctx,
      ) submit;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var email='';
  var username='';
  var password='';
  var isLogin=true;
  void _trySubmit(){
    final isValid=_formKey.currentState?.validate();
    if(!kIsWeb&&Platform.isAndroid)Focus.of(context).unfocus();
    if(isValid==true){
      _formKey.currentState?.save();
      widget.submit(
          email.toString().trim(),
          username.toString().trim(),
          password.toString().trim(),
          isLogin,
          context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Flutter Chat",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            TextFormField(
              key: const ValueKey('Email'),
              validator: (value){
                if(value!=null&&(value.isEmpty||!value.contains('@'))){
                  return "Enter a valid email address!";
                }
                return null;
              },
              onSaved: (value){
                email=value!;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text("Email Address"),
              ),
            ),
            !isLogin?TextFormField(
              key: const ValueKey('Username'),
              validator: (value){
                if(value!=null&&(value.isEmpty||value.length<4)){
                  return "Username must contain at least 4 characters!";
                }
                return null;
              },
              onSaved: (value){
                username=value!;
              },
              decoration: const InputDecoration(
                label: Text("Username"),
              ),
            ):const SizedBox(height: 0,),
            TextFormField(
              key: const ValueKey('Password'),
              validator: (value){
                if(value!=null&&(value.isEmpty||value.length<7)){
                  return "Password must contain at least 7 characters!";
                }
                return null;
              },
              onSaved: (value){
                password=value!;
              },
              decoration: const InputDecoration(
                label: Text("Password"),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: _trySubmit,
              child: isLogin?const Text("Login"):const Text("Sign Up"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: (){
                setState(() {
                  isLogin=!isLogin;
                });
              },
              child: isLogin?const Text("Create A New Account",
                style: TextStyle(
                  color: Colors.white
                ),
              ):const Text("Login Instead",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ],
        )
    );
  }
}