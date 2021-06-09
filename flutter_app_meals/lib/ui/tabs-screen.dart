import 'package:flutter/material.dart';
import 'package:flutter_app_meals/ui/categories-screen.dart';
import 'package:flutter_app_meals/ui/favorites-screen.dart';

class TabbsScreen extends StatefulWidget {
  @override
  _TabbsScreenState createState() => _TabbsScreenState();
}

class _TabbsScreenState extends State<TabbsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,child: Scaffold(
      appBar: AppBar(title: Text("Meals",),
      bottom: TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.category),text: "categories",),
          Tab(icon: Icon(Icons.favorite),text: "favorites",)
        ],
      ),),
      body: TabBarView(
        children: <Widget>[
          CategoriesScreen(showAppbar: false,),
          FavoritesScreen(null,null)
        ],
      ),
    ),
    );
  }
}
