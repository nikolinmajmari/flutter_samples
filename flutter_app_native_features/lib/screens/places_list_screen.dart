import 'package:flutter/material.dart';
import 'package:flutter_app_native_features/providers/places_provider.dart';
import 'package:flutter_app_native_features/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Places List"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, AddPlaceScreen.ROUTE);
          },)
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context,listen: false).loadPlaces(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          print("builder");
          if(snapshot.hasError)
            print(snapshot.error);
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          return Consumer<PlacesProvider>(
            builder: (BuildContext context, PlacesProvider value, Widget child) {
              return value.items.length>0
                  ?ListView.builder(
                itemCount: value.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                    },
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        value.items[index].image,
                      ),
                    ),
                    title: Text(value.items[index].title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,color: Theme.of(context).primaryColorDark,),
                      onPressed: (){
                        value.deletePlace(value.items[index].id);
                      },
                    ),
                  );
                },
              ):child;
            },
            child: Center(
              child: Text("No places added yet"),
            ),
          );
        },
      ),
    );
  }
}
