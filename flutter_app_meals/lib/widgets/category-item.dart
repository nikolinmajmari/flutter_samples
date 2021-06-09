import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_meals/ui/category-meals-screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;
  CategoryItem({this.title, this.color, this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: Theme.of(context).primaryColor,
        /*onDoubleTap: ()=>Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) { return CategoryMealsScreen(); }

        )),*/
        onDoubleTap: () => Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) {
            return CategoryMealsScreen(
              id: id,
              title: title,
              color: color,
            );
          }),
        ),
        onTap: ()=>Navigator.of(context).pushNamed(CategoryMealsScreen.Route,
            arguments:{'id':id, 'color':color, 'title':title}),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Hero(
              tag: id,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [color.withOpacity(0), color.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
