
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  
  Future <void> _getLocationData()async{
    final location = await Location().getLocation();
    print(location.latitude);
    print(location.longitude);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5,color: _previewImageUrl==null? Colors.grey :
            Theme.of(context).primaryColor)
          ),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Center(
                child: Text(
                    "No location chosen",style: TextStyle(color:  Theme.of(context).primaryColorDark,fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
              )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OutlineButton.icon(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                highlightColor: Theme.of(context).primaryColorLight,
                onPressed: () {
                  this._getLocationData();
                },
                icon: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColorDark,
                ),
                label: Text(
                  "Current location",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            OutlineButton.icon(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                highlightColor: Theme.of(context).primaryColorLight,
                onPressed: () {},
                icon: Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColorDark,
                ),
                label: Text(
                  "Select on map",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))
          ],
        )
      ],
    );
  }
}
