import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/dummy-data.dart';
import 'package:flutter_app_meals/ui/bottom-tabs-sceeen.dart';
import 'package:flutter_app_meals/ui/categories-screen.dart';
import 'package:flutter_app_meals/ui/category-meals-screen.dart';
import 'package:flutter_app_meals/ui/filters-screen.dart';
import 'package:flutter_app_meals/ui/tabs-screen.dart';

import 'model/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters = {
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false
  };

  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals =<Meal>[];
  void _setFilters(Map<String,bool> data){
    setState(() {
      _filters = data;
      _avaliableMeals = DUMMY_MEALS.where((element) {
        if(_filters["gluten"]&&!element.isGlutenFree)
          return false;
        if(_filters['lactose']&&!element.isLactoseFree)
          return false;
        if(_filters['vegan']&&!element.isVegan)
          return false;
        if(_filters['vegetarian']&&!element.isVegetarian)
          return false;
        return true;
      }).toList();
    });
  }

  void _toogleFavorite(String mealId){
    print("togling  $mealId");
    print(_favoriteMeals);
    final index = _favoriteMeals.indexWhere((meal)=>meal.id == mealId);
    if(index>=0) {
      print("removing $mealId");
      setState(() {
        _favoriteMeals.removeAt(index);
      });
    }
      else{
       setState(() {
         _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id ==mealId));
       });
      }
    }
  @override
  Widget build(BuildContext context) {
    print("main${this._toogleFavorite}");
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.orangeAccent,
        canvasColor: Color(0xffe7e7e7),
        fontFamily: 'RealeWay',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            color: Colors.white
          ),
          body1: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoCondensed',
              fontSize: 16
          ),
          body2: TextStyle(
            color: Colors.black,
            fontFamily: 'RaleWay',
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        )
      ),
      home: BottomTabsScreen(_favoriteMeals,_toogleFavorite),
      routes: {
        CategoryMealsScreen.Route:(_)=>CategoryMealsScreen( favorites:_favoriteMeals,availableMeals: _avaliableMeals,toggleFavorite: this._toogleFavorite,),
        FiltersScreen.ROUTE:(_)=>FiltersScreen(this._setFilters,this._filters)
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}