
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/mixin/StateNotifier.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/serice_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth.dart';

class ProductsProvider with ChangeNotifier,StateNotifier {
  List<Product> _items = [/*
   Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
   */];

  Auth auth;
  ProductsProvider prev;
  ProductsProvider({this.auth,this.prev}) {
    favoritesOnly = false;
    if(prev!=null){
      _items = prev.items;
    }
  }

  void update(Auth auth){
    this.auth = auth;
  }
  List<Product> get items {
    if (favoritesOnly)
      return [
        ..._items.where((element) => element.isFavorite).toList()
      ]; //.map((e) => e.clone()).toList()];
    return [..._items]; //.map((e) => e.clone()).toList()];
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    try {
       String a  =  filterByUser?'&orderBy="creatorId"&equalTo="${auth.userId}"':"";
      final response = await http.get('${App.DBSERVER}/product.json?auth=${auth.token}$a');
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      final List<Product> loaded = [];
      final user = auth.userId;
      final token = auth.token;
      final favorites = await http.get("${App.DBSERVER}/favorite/$user.json?auth=${token}");
      final fav = json.decode(favorites.body);
      extractedData.forEach((pid, pdata) {
        loaded.add(Product(
          id: pid,
          title: pdata["title"],
          imageUrl: pdata["imageUrl"],
          description: pdata["description"],
          price: pdata["price"],
          isFavorite:fav==null?false: (fav[pid]?? false),
        ));
      });
      _items = [...loaded];
    } catch (error){
      _items = [];
    }
    finally {
      notifyListeners();
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final i = _items.indexWhere((element) => element.id == id);
    if (i >= 0) {
      final product = newProduct;
      final url = "${App.DBSERVER}/product/$id.json?auth=${auth.token}";
      final value = await http.patch("$url",
          body: json.encode({
            "title": product.title,
            'description': product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "isFavorite": product.isFavorite,
            "creatorId":auth.userId
          }));
      _items[i] = Product(
        price: newProduct.price,
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        title: newProduct.title,
        id: id,
        isFavorite: false,
      );
      notifyListeners();
      return Future.value();
    }
    throw Error();
  }

  Future<void> deleteProduct(String id)async {
    final url = "${App.DBSERVER}/product/$id.json?auth=${auth.token}";
    final index = _items.indexWhere((element) => element.id == id);
    var product = _items[index];
    _items.removeAt(index);
    notifyListeners();
    final response = await http.delete(url);
    print(response.statusCode);
    if (response.statusCode <= 400) {
      product = null;
      return Future.value();
    } else {
      _items.insert(index, product);
      notifyListeners();
      throw HttpException("Cant delete product");
    }
  }

  List<Product> get favitems {
    return [
      ..._items.where((element) => element.isFavorite).toList()
    ]; //.map((e) => e.clone()).toList()];
  }

  bool favoritesOnly = false;
  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = App.DBSERVER;
    final value = await http.post("$url/product.json?auth=${auth.token}",
        body: json.encode({
          "title": product.title,
          'description': product.description,
          "imageUrl": product.imageUrl,
          "price": product.price,
          "id": DateTime.now().toString(),
          "creatorId":auth.userId
        }));
    final id = json.decode(value.body)["name"];
    _items.add(Product(
        id: id,
        title: product.title,
        imageUrl: product.imageUrl,
        description: product.description,
        price: product.price,
        isFavorite: false));
    notifyListeners();
  }
}
