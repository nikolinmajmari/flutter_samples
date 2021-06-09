
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class OrdersScreen extends StatefulWidget {
  static const ROUTE="/item-orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Orders>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders Screen "),
      ),
      body: FutureBuilder(
        future: provider.fetchOrders(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else {
            if (snapshot.hasError) {
              return Center(
                child: FlatButton(
                  child: Text("Error Click to reload"),
                  onPressed: () => setState(() => 1),
                ),
              );
            }
            else {
              return OrderList();
            }
          }
        }
      ),
    );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((value) {
      Provider.of<Orders>(context, listen: false).fetchOrders();
    });
    super.initState();
  }
}

class OrderList extends StatelessWidget {
  const OrderList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return orders.length==0? Center(child: Text("on odrders yet"),):ListView.builder(
      itemCount: orders.length,
      itemBuilder: (contx,index){
        return OrderScreenItem(
          key: ValueKey(orders[index].id),
          order: orders[index],
        );
      },
    );
  }
}
class OrderScreenItem extends StatefulWidget {
  final OrderItem order;

  const OrderScreenItem({Key key, this.order}) : super(key: key);
  @override
  _OrderScreenItemState createState() => _OrderScreenItemState();
}

class _OrderScreenItemState extends State<OrderScreenItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.order.id),
            subtitle: Text(widget.order.amount.toString()),
            trailing: IconButton(
              icon: Icon(expanded?Icons.expand_less:Icons.expand_more),
              onPressed: ()=>setState(()=>expanded=!expanded),
            )
          ),
            AnimatedContainer(
              height: expanded? min(widget.order.products.length*20.0 +60.0,180.0):0,
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(8),
              child: ListView(
                children: widget.order.products.map((e) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                    child: Text("${e.quantity} of ${e.title}"),
                  ),
                ).toList(),
              ),
            )
        ],
      ),
    );
  }
}
