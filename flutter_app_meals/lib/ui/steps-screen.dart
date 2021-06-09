import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/meal.dart';

class StepsScreen extends StatelessWidget {
  final Meal meal;
  final Color color;
  const StepsScreen({Key key, this.meal, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Steps Details"),backgroundColor: color,),
      body: Hero(
        tag: "steps${meal.id}",
        child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                child: ListView.builder(itemBuilder:
                    (context,index){
                  String step = meal.steps[index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("$index",style: TextStyle(color: Colors.white),),
                          backgroundColor: color.withOpacity(0.7),
                        ),
                        title: Text(step),
                      ),
                      Divider()
                    ],
                  );
                }
                  ,itemCount: meal.steps.length,)
            )
      ),
    );
  }
}
