import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_native_features/providers/places_provider.dart';
import 'package:flutter_app_native_features/widgets/image_input.dart';
import 'package:flutter_app_native_features/widgets/location_input.dart';
import 'package:provider/provider.dart';
class AddPlaceScreen extends StatefulWidget {
  static const ROUTE = "/add_new_place";
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage)=> this._pickedImage = pickedImage;

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null)
      return;
    Provider.of<PlacesProvider>(context,listen: false).addPlace(_titleController.text, _pickedImage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Place"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
          ),
        ],
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    controller: _titleController,
                  ),
                  SizedBox(height: 8,),
                  ImageInput(
                    notifier:this._selectImage
                  ),
                  SizedBox(height: 8,),
                  LocationInput(),
                ],
              ),
            ),
          ),
        ),
      ),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
           child: RaisedButton.icon(
              onPressed: (){
                _savePlace();
                Navigator.pop(context);
              },
              icon: Icon(Icons.add,color: Colors.white,),
              label: Text("Add Place"),
            elevation: 0,
             color: Theme.of(context).primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            highlightColor: Theme.of(context).primaryColorDark,
            textColor: Colors.white,splashColor: Theme.of(context).primaryColorLight,
        ),
         ),
    ],
    ),
    );
  }
}
