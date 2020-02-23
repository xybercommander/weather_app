import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Weather {

  String cityName;

  Weather({this.cityName});

  Future<void> getWeather() async {

    try {

      // Api key = 9cc4d396352649cab1e283fea41427fd
      Response response = await get("https://api.weatherbit.io/v2.0/forecast/daily?city=$cityName&key=9cc4d396352649cab1e283fea41427fd");

      Map data = jsonDecode(response.body);      
      // print(data['data']);
      List dataList = data['data'];
      Map day1 = dataList[0];
      Map day2 = dataList[1];
      print('Values of day1 : ');
      print(day1);
      print('Values of day2 : ');
      print(day2);

    } catch (e) {  
      print(e);
      print('Could not retrieve data');
    }

  }

}