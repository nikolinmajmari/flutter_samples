import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;
class ChatScreen extends StatefulWidget {
  static const Route = "/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = new GlobalKey<FormState>();
  FirebaseUser loggedUser;
  String messageText;
  final  messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getMessages() async {
    final messages = await _firestore.collection("messages").getDocuments();
    for (var message in messages.documents) {
      print(message.data);
    }
  }

  void getMessageStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.documents) print(message.data);
    }
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    if (user != null){
      setState(() {
        loggedUser = user;
      });
      print(loggedUser.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                getMessageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           loggedUser!=null?MessageStream(loggedUser: loggedUser,):Center(child: CircularProgressIndicator(),),
           Form(
             key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.5)
              ),
                padding: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(48))
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.blue, // button color
                          child: InkWell(
                            splashColor: Colors.red, // inkwell color
                            child: SizedBox(width: 50, height: 50, child: Icon(Icons.send,color: Colors.white,)),
                              onTap: () {
                                messageController.clear();
                                _firestore.collection("messages").add(
                                    {"text": messageText, "sender": loggedUser.email,"ts":FieldValue.serverTimestamp()});
                              },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget{
  final loggedUser;

  const MessageStream({ this.loggedUser}) ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").orderBy("ts").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data;
            final msgcollection = messages.documents.reversed.toList();
            List<Widget> messageWidgets = [];
            final a = true;
          if(a)
            return Expanded(
              child: ListView.builder(
                reverse: true,
                cacheExtent: 100,
                itemCount: messages.documents.length,
                itemBuilder: (BuildContext context, int index) {
                var msgtext = msgcollection[index].data["text"];
                var msgsender = msgcollection[index].data["sender"];
                return MessageBuble(
                  sender: msgsender,text: msgtext,owner: msgsender==loggedUser.email,
                );
              },),
            );
            for (var message in messages.documents) {
              var msgtext = message.data["text"];
              var msgsender = message.data["sender"];
              messageWidgets.add(
                  MessageBuble(
                    sender: msgsender,text: msgtext,owner: msgsender==loggedUser.email,
                  )
              );
            }
            return Expanded(
              child: ListView(
                children: messageWidgets,
              ),
            );
          }
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
  }

}



class MessageBuble extends StatelessWidget{

  final String sender;
  final String text;
  final  bool owner ;
  const MessageBuble({Key key, this.sender, this.text,this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding:EdgeInsets.only(top:0 ,bottom: 0,left: owner?60:8,right: !owner?60:8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: !owner?CrossAxisAlignment.start:CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(sender),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(!owner?0:16),
              topRight:  Radius.circular(owner?0:16),
              bottomLeft:  Radius.circular(16),
              bottomRight:  Radius.circular(16)
            ),
            color: owner?Colors.blueAccent:Colors.blueGrey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "$text",style: TextStyle(fontSize: 18,color: Colors.white),
              ),
            ),
          ),
        ],
      )
    );
  }

}