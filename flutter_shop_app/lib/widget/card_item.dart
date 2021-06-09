import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/card.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final double price;
  final String title;
  final int quantity;
  final String id;
  final String productId;

  const CardItem(
      {Key key, this.price, this.title, this.quantity, this.id, this.productId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: IconButton(
          icon: Icon(Icons.delete),
        ),
      ),
      confirmDismiss: (direction){
       return  showDialog(context: context,
          builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Shop App"),
            content: Text("do you whant to remove this product from order ?"),
            actions: <Widget>[
              FlatButton(child: Text("yed"),onPressed: (){
                Navigator.of(ctx).pop(false);
              },),
              FlatButton(child: Text("yes"),onPressed: (){
                Navigator.of(ctx).pop(true);
              },),
            ],
          );
          },
            );
      },
      onDismissed:(direction) {
    Provider.of<Cart>(context, listen: false).removeItem(productId);
    },
      direction: DismissDirection.endToStart,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("\$$price"))),
            ),
            title: Text("$title"),
            subtitle: Text("Total \$${quantity * price}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
