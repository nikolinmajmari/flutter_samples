import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/providers/card.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/OrdersScreen.dart';
import 'package:flutter_shop_app/screens/auth_screen.dart';
import 'package:flutter_shop_app/screens/card_screen.dart';
import 'package:flutter_shop_app/screens/edit-product-screen.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:flutter_shop_app/screens/product_feed_screen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:flutter_shop_app/widget/app_drawer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create:(_)=> Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,ProductsProvider>
          (
          update: (_,auth,prev){
            print("running update $auth");
            return ProductsProvider(auth: auth,prev:prev);},
        ),
        ChangeNotifierProvider<Cart>(create: (_)=>Cart(),),
        ChangeNotifierProxyProvider<Auth,Orders>(
          update: (_,auth,old)=>Orders(auth,old),
        )
      ],
        child: Consumer<Auth>(
          builder: (ctx,auth,_){
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xffe7e7e7),
                primarySwatch: Colors.pink,
                accentColor: Colors.pinkAccent,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: auth.isAuth ? ProductFeedScreen(): FutureBuilder(
                future: auth.tryAuthLogin(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  print(snapshot.data);
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return AuthScreen();
                },

              ),
              routes: {
                "/home":(_)=>ProductFeedScreen(),
                ProductDetailsScreen.ROUTE:(_)=>ProductDetailsScreen(),
                CartScreen.ROUTE:(_)=>CartScreen(),
                OrdersScreen.ROUTE:(_)=>OrdersScreen(),
                UserProductsScreen.ROUTE:(_)=>UserProductsScreen(),
                EditProductScreen.ROUTE:(_)=>EditProductScreen()
              },
            );
          },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '"',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
