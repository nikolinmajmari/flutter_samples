import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/screens/OrdersScreen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Hello Friend"),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          Divider(),
          Expanded(
              child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home Screen"),
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text("Orders "),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => OrdersScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Products Dashboard"),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(UserProductsScreen.ROUTE);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Log Out"),
                onTap: (){
                  Navigator.of(context).pop();
                  Provider.of<Auth>(context,listen: false).logOut();
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text("Userdat"),
                onTap: (){
                  Navigator.of(context).pop();
                  SharedPreferences.getInstance().then((value) => print(value.get("userdata")));
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
