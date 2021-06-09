

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/edit-product-screen.dart';
import 'package:flutter_shop_app/widget/UserProductItem.dart';
import 'package:provider/provider.dart';


class UserProductsScreen extends StatelessWidget {
  static const ROUTE = "/user-products";

  Future<void> _refreshProducts(BuildContext context)async{
    await Provider.of<ProductsProvider>(context,listen: false).fetchProducts(true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.ROUTE);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child:  CircularProgressIndicator(),);
          else return RefreshIndicator(
            onRefresh:()=> _refreshProducts(context),
            child: Consumer<ProductsProvider>(
              builder: (BuildContext context, ProductsProvider value, Widget child) {
                final productsData = value;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: productsData.items.length,
                    itemBuilder: (context,i){
                      final item = productsData.items[i];
                      return UserProductItem(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        id: item.id,
                      );
                    },
                  ),
                );
              },
            )
          );
        },

      )
    );
  }
}
