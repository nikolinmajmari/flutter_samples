import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const kapiKey = "a6c6a8d162f07a483e0fb85fb5219314";
class WeatherModel {
  WeatherModel();
  String api = "https://api.openweathermap.org/data/2.5/weather";
  Future<dynamic> getLocationWeather()async{
    var location = LocationService();
    await location.getLocation();
    String uri = "https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$kapiKey&units=metric";
    NetworkService service = NetworkService(url: uri);
    var weatherdata = await service.getData();
    return weatherdata;
  }

  Future<dynamic> getCityWeather(String city) async{
    var url = "$api?q=$city&appid=$kapiKey&units=metric";
    print(url);
    var data = await NetworkService(url: url).getData();
    print(" on name ");
    print(data);
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(var temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
