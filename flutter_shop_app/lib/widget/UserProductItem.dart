import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/edit-product-screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;

  const UserProductItem({Key key, this.title, this.imageUrl, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,),
              onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.ROUTE,arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete,color: Theme.of(context).errorColor,),
              onPressed: () async {
                try{
                 await Provider.of<ProductsProvider>(context,listen: false).deleteProduct(id);
                  scaffold.hideCurrentSnackBar();
                  scaffold.showSnackBar(
                      SnackBar(content: Text("Item Deleted"),
                      )
                  );
                }catch(error){
                  scaffold.hideCurrentSnackBar();
                  scaffold.showSnackBar(
                      SnackBar(content: Text("deletion falied "),
                      )
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
