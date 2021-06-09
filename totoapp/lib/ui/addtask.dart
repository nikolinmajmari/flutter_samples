import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totoapp/model/notifier.dart';
import 'package:totoapp/model/task.dart';
import 'package:totoapp/model/taskData.dart';

class AddTaskModal extends StatefulWidget {
  /*final repository;

  final notifier;

  AddTaskModal({this.notifier,this.repository});*/

  @override
  _AddTaskModalState createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
 /* final Notifier notifier;

  final List<Task> repository;*/

   String text;

  _AddTaskModalState();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Color(0xff757575).withOpacity(1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),topLeft: Radius.circular(32)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Add Task",style: TextStyle(fontSize: 32,color: Colors.deepOrange,),textAlign: TextAlign.center,),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                focusColor: Colors.deepOrange,
                hintText: "Task here ",
                labelStyle: TextStyle(
                  color: Colors.white
                )
              ),
              onChanged: (t)=>text=t,
            ),
            SizedBox(height: 20,),
            FlatButton(
              color: Colors.deepOrange,
              child: Text("Add",style: TextStyle(color: Colors.white),),
              padding: EdgeInsets.all(5),
              onPressed: (){
                print("pressed");
                var task = Task(name: text,isDone: false);
                Provider.of<TaskData>(context,listen: false).addTask(task);
                //repository.add(task);
                //notifier.notifyChange();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
