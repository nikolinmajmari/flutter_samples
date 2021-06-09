
import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/meal.dart';
import 'package:flutter_app_meals/ui/steps-screen.dart';

class MealDetail extends StatefulWidget {
  final Meal meal;
  final Color color;
  final bool favorite;
  final Function delete;
  final Function addToFavorites;
  const MealDetail({Key key, this.meal, this.color, this.delete,this.favorite, this.addToFavorites}) : super(key: key);

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  bool isFavorite;
  @override
  void initState() {
    isFavorite = widget.favorite;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    Widget image = SizedBox(
      width:400,
      child: Hero(
        tag: widget.meal.imageUrl,
        child: Image.network(widget.meal.imageUrl,fit: BoxFit.cover,),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.meal.title),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed:(){
         /* Navigator.of(context).pop(
          {"favorite":true,
            "delete":false,
          "meal":widget.meal}
        );*/
      //  print("mealid ${widget.delete}");
        widget.addToFavorites(widget.meal.id);
        setState(() {
          isFavorite=!isFavorite;
        });
        },
        child: Icon(isFavorite?Icons.favorite:Icons.favorite_border,color: Colors.red,),
      ),
      body:SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            image,
            //SizedBox(height: 20,width: 10,),
            Text("Ingridients",style: TextStyle(fontSize: 18,color: Colors.black),),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: widget.color)
                ),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                padding: EdgeInsets.all(8),
                child: Wrap(
                  children: widget.meal.ingredients.map((e) =>
                      Card(
                        color: widget.color,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                          child: Text(e,style: TextStyle(color: Colors.white),),
                        ),
                      )
                  ).toList(),
                )
            ),
            //Divider(),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(
                      Icons.navigate_next
                  ),
                  onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(
                      builder: (_)=>StepsScreen(meal: widget.meal,color: widget.color,)
                  )),
                ),
                Text("Steps ",style: TextStyle(color: widget.color),)
              ],
            ),
            Wrap(
                children: <Widget>[
                  ... widget.meal.steps.map((e) {
                    int index = widget.meal.steps.indexOf(e);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text("1",style: TextStyle(color: Colors.white),),
                            backgroundColor: widget.color.withOpacity(0.7),
                          ),
                          title: Text(e),
                        ),
                        Divider()
                      ],
                    );
                  }).toList()
                ],
              ),
          ],
        ),
      )
    );
  }
}
