import 'dart:convert';
import 'package:http/http.dart';

const kapiKey = "a6c6a8d162f07a483e0fb85fb5219314";
class NetworkService {
  NetworkService({this.url});

  final String url;
   Future getData()async {
    Response response = await get(url);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode ==200){
      String data = response.body;
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }

}