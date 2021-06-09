import 'package:flutter/material.dart';
import 'package:flutter_app_meals/model/dummy-data.dart';
import 'package:flutter_app_meals/widgets/category-item.dart';
class CategoriesScreen extends StatelessWidget {
  final bool showAppbar;

  const CategoriesScreen({Key key, this.showAppbar=true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Text("header"),
            ),
          ],
        ),
      ),
      appBar: showAppbar?AppBar(
        title: Text("meals"),
      ):null,
      body: GridView(
        children: <Widget>[
          ...DUMMY_CATEGORIES.map((e) => CategoryItem(title: e.title,color: e.color,id:e.id)).toList()
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250
        ),
      ),
    );
  }
}
