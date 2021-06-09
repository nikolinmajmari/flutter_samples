import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/buttons.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const Route = "/";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation easeout;
  int c = 0;
  bool direction = true;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      upperBound: 1,
      vsync: this,
    );
    easeout = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    /*controller.addStatusListener((status) {
      print(status);
      if(status==AnimationStatus.completed)
        {controller.reverse(from: 1.0);direction=false;}
      else if(status==AnimationStatus.dismissed){
        controller.forward();
         direction=true;
      }
    });
     */
    controller.addListener(() {
      setState(() {
        /* if(direction)c++;
        else c--;
        */
      });
      print(controller.value);
      print("ease ${easeout.value}");
    });
    controller.forward();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: easeout.value > 0 ? easeout.value * 60 : 0,
                  ),
                ), TypewriterAnimatedTextKit(
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    text: <String>['Flash Chat'],
                  ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Hero(
              tag: "loginButton",
              child: RoundedButton(
                title: "login",
                color: Colors.lightBlueAccent,
                onPress: ()=>Navigator.pushNamed(context, LoginScreen.Route),
              ),
            ),
            Hero(
              tag: "registerButton",
              child: RoundedButton(
                title: "Register",
                color: Colors.blueAccent,
                onPress: ()=>Navigator.pushNamed(context, RegistrationScreen.Route),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

