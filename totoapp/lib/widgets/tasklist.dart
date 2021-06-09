import 'package:provider/provider.dart';
import 'package:totoapp/model/notifier.dart';
import 'package:totoapp/model/taskData.dart';
import 'package:totoapp/ui/tasks.dart';
import 'package:flutter/material.dart';
import 'package:totoapp/model/task.dart';
import 'listtile.dart';

class TaskList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
            itemCount: taskdata.tasks.length,
            itemBuilder: (context,index){
              return TaskTile(
                toogle:taskdata.tasks[index].isDone,
                title: taskdata.tasks[index].name,
                notifier: (value){
                  taskdata.tasks[index].toogleDone();
                },
                onLongPress: (){
                  taskdata.removeTask(index);
                }
              );
            });
      },
    );
  }
}

/*
(
      children: tasks.map((e) => TaskTile(
        title: e.name,toogle: e.isDone,notifier: (task){
          e.toogleDone();
          setState(() {

          });
      },
      )).toList()
    );
 */