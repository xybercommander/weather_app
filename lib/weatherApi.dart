import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Weather {

  String cityName;
  String countryCode;
  String date;
  int temp;
  double feelsLike;
  String currentMonth;
  String finalDate;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",  
  ];

  Weather({this.cityName});

  Future<void> getWeather() async {

    try {

      // Api key = 9cc4d396352649cab1e283fea41427fd
      Response response1 = await get("https://api.weatherbit.io/v2.0/forecast/daily?city=$cityName&key=9cc4d396352649cab1e283fea41427fd");
      Response response2 = await get("https://api.weatherbit.io/v2.0/current?city=$cityName&key=9cc4d396352649cab1e283fea41427fd");

      Map data = jsonDecode(response1.body);    
      Map currentDatatemp = jsonDecode(response2.body);
      List tempData = currentDatatemp['data'];
      Map finalTempData = tempData[0];

      // print(data['data']);
      List dataList = data['data'];
      Map day0 = dataList[0];      
      Map day1 = dataList[1];
      Map day2 = dataList[2];
      date = day0['datetime'];
      
      if(date[5] == '0'){
        currentMonth = months[int.parse(date[6]) - 1];        
      }else {
        currentMonth = months[(int.parse(date[6]) + 10) - 1];
      }
      finalDate = "$currentMonth ${date.substring(8)}, ${date.substring(0, 4)}";      
      countryCode = data['country_code'];
      temp = finalTempData['temp'];
      feelsLike = finalTempData['app_temp'];

      // print('Values of day1 : ');
      // print(day1);
      // print('Values of day2 : ');
      // print(day2);

    } catch (e) {  
      print(e);
      print('Could not retrieve data');
    }

  }

}