import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const Route = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
              'Login Falied '),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 40,horizontal: 24),
            child: Text(
                'Incorrect Credentials check username and password '),
          ),
          /*
          actions: <Widget>[
              CupertinoDialogAction(
              child: Text('Don\'t Allow'),
              onPressed: () {
              Navigator.of(context).pop();
              },
              ),
              CupertinoDialogAction(
              child: Text('Allow'),
              onPressed: () {
              Navigator.of(context).pop();
              },
              ),
              ],
          */
        );
      },
    );
  }

  String username,password;
  bool inAsyncCall=false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    padding: EdgeInsets.all(48),
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  username = value;
                },
                decoration: kInputDecoration.copyWith(
                  hintText: "enter email",
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(
                    hintText: "enter password"
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Hero(
                tag: "loginButton",
                child: RoundedButton(
                  title: "login",
                  color: Colors.lightBlueAccent,
                  onPress: ()async{
                    try{
                      setState(() {
                        inAsyncCall=true;
                      });
                      final user = await _auth.signInWithEmailAndPassword(email: username, password: password);
                      if(user!=null){
                        print("auth");
                        print(user.toString());
                        await Navigator.pushNamed(context, ChatScreen.Route);
                      }
                    }catch(e){
                      print(e);
                      _showDialog();
                    }finally{
                      setState(() {
                        inAsyncCall = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 24.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

