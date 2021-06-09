
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;
  const CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price
  });
}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items = {};
  Map<String, CartItem> get items{
    return{..._items};
  }
  void addItem(String productID,double price, String title){
    if(_items.containsKey(productID)){
      _items.update(productID, (value) => CartItem(
        id: value.id,
        title: value.title,
        price: value.price,
        quantity: value.quantity+1
      ));
    }else{
      _items.putIfAbsent(productID, () => CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  void removeItem(String dkey){
    _items.removeWhere((key, value) => key==dkey);
    notifyListeners();
  }

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId))
      return;
    else if(_items[productId].quantity>1)
      _items.update(productId, (value) => CartItem(
        title: value.title,
        id: value.id,
        quantity: value.quantity-1,
        price: value.price,
      ));
    else  _items.removeWhere((key, value) => key==productId);
  }
  double get totalAmount{
    double total = 0;
    _items.forEach((key, value) {
      total+=value.quantity*value.price;
    });
    return total;
  }
int  get getItemCount{
    return _items.length;
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}