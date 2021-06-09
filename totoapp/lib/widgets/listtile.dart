

import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget{
  final Function notifier;
  final bool toogle;
  final String title;
  final Function onLongPress;
  const TaskTile({this.notifier, this.toogle, this.title, this.onLongPress}) ;
  @override
  State<StatefulWidget> createState() =>TaskTileState(notifier: notifier,title: title,toogle: toogle,onLongPress: onLongPress);

}



class TaskTileState extends State<TaskTile>{
  
  final Function notifier;
   bool toogle;
   String title;
   Function onLongPress;
  TaskTileState({this.notifier, this.toogle,this.title,this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      trailing: Checkbox(value: toogle,activeColor: Colors.deepOrange,onChanged: (val){
        setState(() {
          toogle=!toogle;
          notifier(toogle);
        });
      },),
      title: Text(title,style: TextStyle(decoration: toogle?null: TextDecoration.lineThrough),),
     );
  }
}
