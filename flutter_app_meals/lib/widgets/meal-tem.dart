
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/meal.dart';
import 'package:flutter_app_meals/ui/meal-detail.dart';

class MealItem extends StatelessWidget {

  final GlobalKey<ScaffoldState> scfkey;
  final Meal meal;
  final bool isFavorite;
  final Function addToFavorites;
  final Color color;
  final Function handleRemove;
  final Function addItem;
  const MealItem({Key key,this.meal, this.color, this.handleRemove, this.addItem, this.scfkey, this.addToFavorites, this.isFavorite}) : super(key: key);
  void _selectMeal(context){
    print("handle reomve $handleRemove");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_)=>MealDetail(meal: meal,color:color,delete: handleRemove,addToFavorites: addToFavorites,favorite: this.isFavorite,)
    )).then((value) {
      if(value==null)
        return;
   /*   Meal meal = value['meal'];
      bool action = value["favorite"];
      String message = action?"Added To Favorites":"Removed From Favorites ";
    // scfkey.currentState.removeCurrentSnackBar();
      scfkey.currentState.showSnackBar( SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(flex: 2, fit: FlexFit.loose,child: Text("$message",softWrap: true,)),
            FlatButton(
              child: Text("Undo Delete"),
              onPressed: (){
                addItem(meal);
              },
            )
          ],
        ),
      ));*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> _selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                  child: Hero(
                    tag: meal.imageUrl,
                    child: Image.network(meal.imageUrl,height: 200,width: double.infinity,fit: BoxFit.cover,),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: Container(
                    width: 200,
                    color: Colors.black45,
                    child: Text(meal.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(width: 6,),
                      Text('${meal.duration} min',style: TextStyle(color: Colors.black),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(width: 6,),
                      Text('${meal.getComplexity}',style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(width: 6,),
                      Text('${meal.getAffortability}',style: TextStyle(color: Colors.black)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
