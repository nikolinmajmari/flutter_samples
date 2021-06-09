import 'dart:io';

import 'package:flutter/foundation.dart';
class LocationModel{
  final double latitude;
  final double longitude;
  final String address;
  LocationModel(this.latitude, this.longitude, this.address);
}


class Place{
  final String id;
  final String title;
  final location;
  final File image;
  Place({this.id, this.title, this.location, this.image});
}