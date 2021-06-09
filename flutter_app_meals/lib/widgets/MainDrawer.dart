import 'package:flutter/material.dart';
import 'package:flutter_app_meals/ui/filters-screen.dart';
const dtstyle = TextStyle(
  color: Colors.deepOrange,
);
class MainDrawer extends StatelessWidget {
  
  Widget buildListTile(String title,IconData icon,Function tapHandeler){
    return ListTile(
      onTap: tapHandeler,
      leading: Icon(icon,color: Colors.deepOrangeAccent,),
      title: Text(title,style: dtstyle,),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
        color: Color(0xe0e0e0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                "Cooking Up",
                style: TextStyle(color: Colors.white,fontSize: 26),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange
              )
            ),
            buildListTile("categories", Icons.category,()=>Navigator.of(context).pushReplacementNamed('/')),
            buildListTile("Filters", Icons.favorite,(){
              Navigator.pop(context);
              Navigator.pushNamed(context,FiltersScreen.ROUTE);
            }),
          ],
        ),
      )
    );
  }
}
