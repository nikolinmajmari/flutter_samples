import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/providers/card.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductFeedItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Product p = Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    final products = Provider.of<ProductsProvider>(context,listen: false);
    final auth = Provider.of<Auth>(context,listen: false);
    print("${products.items} fjireijfjeifjrejife ");
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(ProductDetailsScreen.ROUTE,arguments:{
            "id":p.id
          });
        },
        child: GridTile(
          child: Hero(tag: "image${p.id}",child: FadeInImage(
            image: NetworkImage(p.imageUrl),
            placeholder: AssetImage("assets/images/pp.png"),
          )),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(p.title,textAlign: TextAlign.center,),
            leading: IconButton(
              color: Theme.of(context).accentColor,
              icon: Consumer<Product>(
                builder: (BuildContext context, Product value, Widget child) {
                  return  Icon(p.isFavorite?Icons.favorite:Icons.favorite_border,color: Colors.red,);
                },
                child: null,
              ),
              onPressed: (){
                print("auth with $auth");
                p.toogleFavorite(auth.token,auth.userId);
              },
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                cart.addItem(p.id, p.price, p.title);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("item added to card "),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: (){
                        cart.removeSingleItem(p.id);
                      },
                    ),
                  )
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
