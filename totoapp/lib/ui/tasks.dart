
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totoapp/model/notifier.dart';
import 'package:totoapp/model/task.dart';
import 'package:totoapp/model/taskData.dart';
import 'package:totoapp/ui/addtask.dart';
import 'package:totoapp/widgets/tasklist.dart';



class TaskScreen extends StatefulWidget{

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List <Task> tasks = [
    Task(name: "Drink the milk",isDone: false),
    Task(name: "Drink the milk",isDone: false),
    Task(name: "Drink the milk",isDone: false),
    Task(name: "Drink the milk",isDone: false),
    Task(name: "Drink the milk",isDone: false),
  ];

  final  Notifier notifier=Notifier();

  @override
  Widget build(BuildContext context) {
    print("building scaffold");
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20,bottom: 30,left: 30,right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    radius: 36,
                    child: Icon(Icons.list,size: 45.0,),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Todoey",
                    style: TextStyle(
                        color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 40
                    ),),
                 Consumer<TaskData>(
                    builder: (BuildContext context, value, Widget child) {
                      return Text("${value.tasks.length}",style: TextStyle(
                        fontSize: 18,color: Colors.white
                      ),);
                    },
                  )

                ],
              )
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 32,bottom: 8,left: 16,right: 64),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)
                    ),
                ),
                child: TaskList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (context)=>SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskModal())
              )
              ,
              isScrollControlled: true
          );
        },
      ),
    );
  }
}

class CountText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Consumer(
      builder: (BuildContext context, value, Widget child) {
        return Text("${value.tasks.length}");
      },
    );
  }

}