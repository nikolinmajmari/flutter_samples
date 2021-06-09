import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:totoapp/model/task.dart';
class TaskData extends ChangeNotifier{
  List <Task> tasks = [
  ];

  int length(){
    return tasks.length;
  }
  void addTask(Task t){
    tasks.add(t);
    notifyListeners();
  }
  void removeTask(index){
    tasks.removeAt(index);
    notifyListeners();
  }
}