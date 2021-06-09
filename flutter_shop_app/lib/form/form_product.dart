import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/product.dart';

class FormProduct  {
  Product getProduct(){
    Product p =  Product(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl:imageUrl,
        isFavorite: isFavorite
    );
    return p;
  }
  String id;
  String title;
   String description;
   double price;
  String imageUrl;
  final bool isFavorite;

  FormProduct( {
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.imageUrl,
    @required this.price, this.isFavorite,
  });

  String  toString(){
    return "$id $description $title $imageUrl $price";
  }
}