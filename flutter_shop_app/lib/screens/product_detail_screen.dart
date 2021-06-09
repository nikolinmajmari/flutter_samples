import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/providers/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const ROUTE ="/product-details";

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments as  Map<String,String>;
    String id = arguments["id"];
    // ...
    Product p = Provider.of<ProductsProvider>(context).items.firstWhere((element) => element.id==id) ;
    if(p!=null)
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(p.title),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(p.title,style: TextStyle(backgroundColor: Colors.black45),),
              background: Hero(
                tag: "image$id",
                child: Image.network(
                  p.imageUrl,fit: BoxFit.contain,height: 300,alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
             /* Hero(
                tag: "image$id",
                child: Image.network(
                  p.imageUrl,fit: BoxFit.contain,height: 300,alignment: Alignment.center,
                ),
              ),*/
              SizedBox(
                height: 10,
              ),
              Text(
                "\$${p.price}",style: TextStyle(
                color: Colors.grey,fontSize: 20,
              ),textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  p.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 800,
              )
            ]
            )
          )
        ],
      ),
    );
    return Container(
      child: Center(
        child: Text("product does not exists"),
      ),
    );
  }
}
