
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/card.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:flutter_shop_app/screens/OrdersScreen.dart';
import 'package:flutter_shop_app/widget/card_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const ROUTE = "/card-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Card "),
      ),
      body: CartScreenBody()
    );
  }
}

class CartScreenBody extends StatefulWidget {


  @override
  _CartScreenBodyState createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",style:  TextStyle(fontSize: 20),),
                  Spacer(),
                  Chip(
                    label: Text("\$${cart.totalAmount}", style: TextStyle(color: Colors.white),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("Order now",style: TextStyle(
                        color: Colors.pink
                    ),
                    ),
                    onPressed:cart.totalAmount<=0 || (isLoading) ? null :  (){
                      setState(() {
                        isLoading  = true;
                      });
                      Provider.of<Orders>(context,listen:false).addOrder(cart.items.values.toList(),cart.totalAmount).then((value){
                        cart.clear();
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Row(
                                  children: <Widget>[
                                    Text("Order Done Succesfully",style: TextStyle(color: Colors.white),)
                                  ],
                                )
                            )
                        );
                        return Future.delayed(Duration(seconds: 2));
                      }).catchError(
                              (error)=>showDialog(context: context,builder: (context){
                            return AlertDialog(
                              title: Text("Shop App"),
                              content: Text("Could not make the order"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("cancel"),
                                  onPressed: ()=>Navigator.of(context).pop(),
                                )
                              ],
                            );
                          })
                      ).whenComplete((){
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          isLoading ? Expanded(child: Center(child: CircularProgressIndicator(),))
              : Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context,index){
                  CartItem item = cart.items.values.toList()[index];
                  print("item ${cart.items}");
                  return CardItem(
                    key: ValueKey(item.id),
                    title: item.title,
                    price: item.price,
                    quantity: item.quantity,
                    id: item.id,
                    productId: cart.items.keys.toList()[index],
                  );
                }),
          ),
        ]
    );
  }
}

