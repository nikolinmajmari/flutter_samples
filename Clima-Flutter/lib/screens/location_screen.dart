import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';


class LocationScreen extends StatefulWidget {
  var locationWeather;

  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  var temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  WeatherModel model = WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   //print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherdata){
    if(weatherdata==null){
      temperature=0.0;
      weatherIcon ="error";
      weatherMessage="error";
      cityName="";
      return;
    }
    temperature = weatherdata["main"]["temp"];
    var condition = weatherdata["weather"][0]["id"];
    weatherIcon = model.getWeatherIcon(condition);
    cityName = weatherdata["name"];
    this.weatherMessage = model.getMessage(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      var weatherData = model.getLocationWeather();
                      weatherData.then((value) {
                        updateUI(value);
                        setState((){});
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname =await  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>CityScreen()
                        )
                      );
                      if(typedname!=null){
                        print("-------------------------------------------------------------------");
                        var data = await model.getCityWeather(typedname);
                        print("------------------------------------------------------------------- 2 ");
                        print(data);
                        setState(() {
                          updateUI(data);
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${temperature.toInt()} °",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in ${this.cityName}",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
