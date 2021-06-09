import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/meal.dart';
import 'package:flutter_app_meals/ui/categories-screen.dart';
import 'package:flutter_app_meals/ui/favorites-screen.dart';
import 'package:flutter_app_meals/widgets/MainDrawer.dart';

class BottomTabsScreen  extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function toogleFavorite;
  const BottomTabsScreen(this.favoriteMeals, this.toogleFavorite,);
  @override
  _BottomTabsScreenState createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  void _slectPage(int index){
    setState(() {
      _selectedPageIndex= index;
    });
  }

  List<Widget> pages;

  @override
  void initState(){
    //print("init state ${widget.toogleFavorite}");
    pages=[
      CategoriesScreen(showAppbar: false,),
      FavoritesScreen(widget.favoriteMeals,widget.toogleFavorite),
    ];
    super.initState();
  }
  int _selectedPageIndex= 0;
  @override
  Widget build(BuildContext context) {
    print("bottom bar ${widget.toogleFavorite}");
    return Scaffold(
      appBar: AppBar(title: Text("Meals"),
          ),
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _slectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellowAccent,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          )
        ],
      ),
      drawer: MainDrawer(),

    );
  }
}
