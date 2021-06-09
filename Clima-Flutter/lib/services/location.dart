import 'package:geolocator/geolocator.dart';

class LocationService{
  double long,lat;
  Future getLocation() async {
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      long = position.longitude;
      lat = position.latitude;
      return position;
    }catch(e){
      print(e.toString());
    }
  }
}