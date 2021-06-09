import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/dummy-data.dart';
import 'package:flutter_app_meals/model/meal.dart';
import 'package:flutter_app_meals/widgets/meal-tem.dart';
class CategoryMealsScreen extends StatefulWidget {
  static const String Route="/category-meals";



  final String id;
  final String title;
  final Color color;

  final List<Meal> availableMeals;
  final List<Meal> favorites;
  final Function toggleFavorite;

  const CategoryMealsScreen({Key key, this.id, this.title, this.color,this.availableMeals, this.favorites, this.toggleFavorite})
      : super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Function  _removeMeal;
// TODO: implement initState
    String ctitle ;
    bool _loadedData = false;
    var cid ;
    var routeArgs;
    Color ccolor ;
  _CategoryMealsScreenState({ this.ctitle, this.cid, this.ccolor});

  List<Meal> meals;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void removeMeal(String mealId){
    setState(() {
      meals.removeWhere((element) => element.id ==mealId);
    });
  }
  void addMeal(Meal meal){
    _scaffoldKey.currentState.removeCurrentSnackBar();
    setState(() {
      meals.add(meal);
    });
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeArgs = ModalRoute.of(context).settings.arguments as Map<String,Object>;
     ctitle = widget.id==null? routeArgs['title']:widget.title;
    cid = widget.title==null?routeArgs['id']:widget.id;
    ccolor =widget.color==null? routeArgs['color']:widget.color;
    if(_loadedData==false)
      {
        meals = widget.availableMeals.where((element){
          return element.categories.contains(cid);
        }).toList();
        _loadedData = true;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(backgroundColor:ccolor,title:  Text(ctitle), actions: <Widget>[IconButton(icon: Icon(Icons.more),)],),
        body: Stack(
          children: <Widget>[
            Hero(
              tag: cid,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [ccolor.withOpacity(0), ccolor.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: ListView.builder(
                itemCount: meals.length,
                  itemBuilder: (context,index){
                  Meal e = meals[index];
                    return MealItem(
                      meal: e,
                      color:ccolor,
                      handleRemove: this.removeMeal,addItem: this.addMeal,
                      scfkey:_scaffoldKey,
                      addToFavorites:widget.toggleFavorite,
                      isFavorite:widget.favorites.indexWhere((element) => element.id==e.id)>=0 ,
                    );
                  }
              )
            ),
          ],
        ));
  }
}
