import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/serice_constants.dart';
import 'package:http/http.dart';
class Product with ChangeNotifier {
  Product clone(){
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
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite=false;

  Product({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite
  }){
    if(this.isFavorite==null)
      this.isFavorite = false;
  }

  void toogleFavorite(String token,String user) async{
    final old = isFavorite;
    isFavorite=!isFavorite;
    notifyListeners();
    try {
      final response = await put("${App.DBSERVER}/favorite/$user/$id.json?auth=${token}",
          body: json.encode(
            isFavorite
          ));
      print(response.body);
      if (response.statusCode > 400) {
        isFavorite = old;
        notifyListeners();
      }
    }catch(error){
      isFavorite = old;
      notifyListeners();
    }
  }


}