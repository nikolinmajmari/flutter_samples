import 'package:flutter/material.dart';
import 'package:flutter_app_native_features/providers/places_provider.dart';
import 'package:flutter_app_native_features/screens/add_place_screen.dart';
import 'package:flutter_app_native_features/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.ROUTE:(_)=>AddPlaceScreen()
        },
      ),
    );
  }
}
