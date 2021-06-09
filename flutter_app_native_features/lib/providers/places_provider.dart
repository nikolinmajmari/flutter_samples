
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_native_features/models/place.dart';
import 'package:flutter_app_native_features/services/database_service.dart';

class PlacesProvider with ChangeNotifier{
  List<Place> _items = [];
  List<Place> get items {return [..._items];}

  Future<void> addPlace(String title,File image){
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: image,
      location: null
    );
    _items.add(newPlace);
    notifyListeners();
    final cnt = DatabaseService.insert(Tables.USER_PLACES,{
      "id":newPlace.id,
      "image":newPlace.image.path,
      "title":newPlace.title,
    });
    print("data saved to sqllite $cnt");
  }

  Future<void> loadPlaces()async{
    _items = await DatabaseService.fetchAndSetPlaces();
    print("[provider/places_provider{loadplaces}]$_items");
  }

  Future<void> deletePlace(String id) async{

    await DatabaseService.delete(Tables.USER_PLACES, id).then((value){
      _items.removeWhere((element) => element.id==id);
      notifyListeners();
    });
  }

}