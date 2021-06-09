import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/meal.dart';
import 'package:flutter_app_meals/widgets/meal-tem.dart';

class FavoritesScreen  extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;

  const FavoritesScreen( this.favoriteMeals, this.toggleFavorite) ;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Function _toogleFavorite ;
  @override
  void initState() {
    _toogleFavorite = (String id){
      widget.toggleFavorite(id);
      setState(() {
      });
    };
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.favoriteMeals.isEmpty){
      return Container(
        child: Center(
          child: Text("You have not favorites "),
        ),
      );
    }
    return ListView.builder(
        itemCount: widget.favoriteMeals.length,
        itemBuilder: (context,index){
          Meal e = widget.favoriteMeals[index];
          return MealItem(
            meal: e,
            color:Colors.orangeAccent.withOpacity(0.4),
            //handleRemove: this.removeMeal,addItem: this.addMeal,
           // scfkey:_scaffoldKey,
            addToFavorites:_toogleFavorite,
            isFavorite:true,
          );
        }
    );
  }
}
