import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/providers/card.dart';
import 'package:http/http.dart' as http;

import '../serice_constants.dart';
class OrderItem with ChangeNotifier{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders=[];

  Orders(this.auth,this.old){
    if(old !=null)
      this._orders = old.orders;
  }
  List<OrderItem> get orders{
    return [..._orders];
  }
  Auth auth;
  Orders old;

  Future<void> fetchOrders()async{
    final url = "${App.DBSERVER}/order/${auth.userId}.json?auth=${auth.token}";
    final response = await http.get(url);
    print(response.body);
    final List<OrderItem> loaded = [];
    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    if(extractedData==null)
      throw HttpException("No orders yet");
    extractedData.forEach((orderId, orderData) {
      loaded.add(OrderItem(
          id: orderId,
          amount: orderData["amount"],
          products: (orderData["products"] as List<dynamic>).map((e) =>
          CartItem(
            price: e["price"],
            id: e["id"],
            title: e["title"],
            quantity: e["quantity"]
          )).toList(),
          dateTime: DateTime.parse(orderData["datetime"])
      )
      );
      print("added");
    });
    _orders = loaded;
    notifyListeners();
    return Future.value();
  }
  
  Future<Void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = "${App.DBSERVER}/order/${auth.userId}.json?auth=${auth.token}";
    final timestamp = DateTime.now();
    final response = await http.post(url,body: json.encode({
      "amount":total,
      "datetime":timestamp.toIso8601String(),
      "products": cartProducts.map((e) =>
      {
        "id":e.id,
        "title":e.title,
        "quantity":e.quantity,
        "price":e.price,
      }).toList()
      }));
    if(response.statusCode>=400)
      throw HttpException("could not save order");
    _orders.insert(0, OrderItem(
        id: json.decode(response.body)["name"],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts
    ));
    notifyListeners();
    return Future.value();
  }
}