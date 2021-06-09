import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RegistrationScreen extends StatefulWidget {

  static const Route = "/register";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: "logo",
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(24),
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email=value;
                },
                decoration: kInputDecoration.copyWith(
                    hintText: "Email Here"
                )
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
                style: TextStyle(color: Colors.black),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(
                    hintText: "Password Here"
                )
            ),
            SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: "registerButton",
              child: RoundedButton(
                title: "Register",
                color: Colors.blueAccent,
                onPress: ()async{
                  try{
                    final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newuser!=null)
                      Navigator.pushNamed(context, ChatScreen.Route);
                  }catch(e){
                    print(e.toString());
                  }
                },
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
