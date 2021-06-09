import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/widget/product_feed_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/providers/product.dart';

class ProductsGrid extends StatelessWidget {

   final bool favorites;
   ProductsGrid(this.favorites);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
   final List<Product> products =  !favorites ? provider.items:provider.favitems;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,childAspectRatio: 3/2,crossAxisSpacing: 8,mainAxisSpacing: 8
        ),
        itemBuilder: (ctx,i)=>
            ChangeNotifierProvider.value(
             value :products[i],
              child: ProductFeedItem(),
            )
    );
  }
}
