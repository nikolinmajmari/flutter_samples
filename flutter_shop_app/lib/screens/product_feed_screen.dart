
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dummy_data.dart' ;
import 'package:flutter_shop_app/providers/card.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/card_screen.dart';
import 'package:flutter_shop_app/widget/app_drawer.dart';
import 'package:flutter_shop_app/widget/badge.dart';
import 'package:flutter_shop_app/widget/product_feed_item.dart';
import 'package:flutter_shop_app/widget/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
  Favorites,
  All
}


class ProductFeedScreen extends StatefulWidget {


  @override
  _ProductFeedScreenState createState() => _ProductFeedScreenState();
}

class _ProductFeedScreenState extends State<ProductFeedScreen> {
  bool onlyFavorites = false;
  bool loaded = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("main Screen"),
      actions: <Widget>[

        PopupMenuButton(itemBuilder: (
            BuildContext context) {
          return [
            PopupMenuItem(
              child: Text("Only Favorites"),
              value: FilterOptions.Favorites,
            ),
            PopupMenuItem(
              child: Text("show all"),
              value: FilterOptions.All,
            )
          ];
        },
          child: Icon(Icons.more_vert),
          onSelected: (FilterOptions options){
          switch(options){
            case FilterOptions.All:
              onlyFavorites= false;
              setState(() {
              });
              break;
            case FilterOptions.Favorites:
              onlyFavorites = true;
              setState(() {
              });
              break;
            default:
              break;
          }
          },
        ),
        Consumer<Cart>(
          builder: (BuildContext context, Cart value, Widget child) {
            return Badge(
              child: child,
              value: value.getItemCount.toString(),
            );
          },
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: ()=>
            Navigator.of(context).pushNamed(CartScreen.ROUTE),
          ),

        )
      ],
      ),
      body: isLoading?Center(child: CircularProgressIndicator(),)
      : ProductsGrid(this.onlyFavorites)
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!loaded){
      final provider = Provider.of<ProductsProvider>(context,listen: false);
      provider.fetchProducts(false);
    }
    super.didChangeDependencies();
  }
}
