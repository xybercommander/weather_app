import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'weatherApi.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'searchPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:async/async.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {  

  Weather obj = Weather(cityName: "Bangalore");    

  String text = "";  
  List<Weather> cities = [];
  List<String> cityNames = [];
  
  int dayIndex = -1;
  

  Map weatherIcons = {
    "Thunderstorm with light rain" : "t01d.png",
    "Thunderstorm with rain" : "t02d.png",
    "Thunderstorm with heavy rain" : "t03d.png",
    "Thunderstorm with light drizzle" : "t04d.png",
    "Thunderstorm with drizzle" : "t04d.png",
    "Thunderstorm with heavy drizzle" : "t04d.png",
    "Thunderstorm with hail" : "t04d.png",
    "Light drizzle" : "d01d.png",
    "Drizzle" : "d01d.png",
    "Heavy drizzle" : "d01d.png",
    "Light rain" : "r01d.png",
    "Moderate rain" : "r01d.png",
    "Heavy rain" : "r03d.png",
    "Freezing rain" : "r01d.png",
    "Light shower rain" : "r01d.png",
    "Shower rain" : "r05d.png",
    "Heavy shower rain" : "r01d.png",
    "Light snow" : "s01d.png",
    "Snow" : "s02d.png",
    "Heavy snow" : "s02d.png",
    "Mix snow/rain" : "s01d.png",
    "Sleet" : "s05d.png",
    "Heavy sleet" : "s05d.png",
    "Snow shower" : "s01d.png",
    "Heavy snow shower" : "s02d.png",
    "Flurries" : "s06d.png",
    "Mist" : "a01d.png",
    "Smoke" : "a01d.png",
    "Haze" : "a01d.png",
    "Sand/dust" : "a01d.png",
    "Fog" : "a01d.png",
    "Freezing Fog" : "a01d.png",
    "Clear Sky" : "c01d.png",
    "Clear sky" : "c01d.png",
    "Few clouds" : "c02d.png",
    "Broken clouds" : "c03d.png",
    "Overcast clouds" : "c04d.png",
    "Scattered clouds" : "c02d.png",
    "Unknown Precipitation" : "r01d.png",
    "null" : "none.png",
  };

  Map weatherBackground = {
    "Thunderstorm with light rain" : "thunder.jpg",
    "Thunderstorm with rain" : "thunder.jpg",
    "Thunderstorm with heavy rain" : "thunder.jpg",
    "Thunderstorm with light drizzle" : "thunder.jpg",
    "Thunderstorm with drizzle" : "thunder.jpg",
    "Thunderstorm with heavy drizzle" : "thunder.jpg",
    "Thunderstorm with hail" : "thunder.jpg",
    "Light drizzle" : "rainyDay.jpg",
    "Drizzle" : "rainyDay.jpg",
    "Heavy drizzle" : "heavyRain.jpg",
    "Light rain" : "rainyDay.jpg",
    "Moderate rain" : "rainyDay.jpg",
    "Heavy rain" : "heavyRain.jpg",
    "Freezing rain" : "heavyRain.jpg",
    "Light shower rain" : "rainyDay.jpg",
    "Shower rain" : "rainyDay.jpg",
    "Heavy shower rain" : "heavyRain.jpg",
    "Light snow" : "snow.jpg",
    "Snow" : "snow.jpg",
    "Heavy snow" : "snow.jpg",
    "Mix snow/rain" : "rainyDay.jpg",
    "Sleet" : "snowShower.jpg",
    "Heavy sleet" : "snowShower.jpg",
    "Snow shower" : "snowShower.jpg",
    "Heavy snow shower" : "snowShower.jpg",
    "Flurries" : "foggy.jpg",
    "Mist" : "foggy.jpg",
    "Smoke" : "foggy.jpg",
    "Haze" : "animeMorning2.jpg",
    "Sand/dust" : "ClearDay2.jpg",
    "Fog" : "foggy.jpg",
    "Freezing Fog" : "aestheticEvening.jpg",
    "Clear Sky" : "clearMorning.jpg",
    "Clear sky" : "clearMorning.jpg",
    "Few clouds" : "CloudyDay.jpg",
    "Broken clouds" : "animeMorning.jpg",
    "Overcast clouds" : "CloudyDay.jpg",
    "Scattered clouds" : "animeMorning.jpg",
    "Unknown Precipitation" : "heavyRain.jpg",
    "null" : "rainyDay.jpg",
  };

  List<String> bg = [];


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(            
            image: DecorationImage(              
              image: AssetImage("assets/bgimg.jpg"),
              fit: BoxFit.fill
            )
          ),   
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.4),
                ]
              )
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,                  
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          // print(dayIndex);
                          return Alert(
                            context: context,
                            title: "Hola!!",
                            desc: "Developed by Xyber",
                            buttons: [
                              DialogButton(
                                child: Text("Awesome!"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                            
                          ).show();
                        },
                        color: Colors.white60
                      ),
                      Text(
                        "Weather",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w200,
                          letterSpacing: 2,
                          color: Colors.white60
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {                          
                          _awaitReturnValueFromSecondScreen(context);                          
                        },
                        color: Colors.white60
                      ),
                    ],
                  ),
                  SizedBox(height: 14,),
                  Expanded(  
                    flex: 1,          
                    child: Container(                                    
                      child: Swiper(                             
                        onIndexChanged: (value) {
                           if(dayIndex != -1){
                             setState(() {
                               dayIndex = value;
                             });
                           }
                        },                              
                        itemCount: cities.length,                        
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 300,
                            child: ClipRRect(                       
                              borderRadius: BorderRadius.circular(30),                            
                              child: Container(
                                decoration: BoxDecoration(                                 
                                  image: DecorationImage(                                  
                                    image: AssetImage("assets/${weatherBackground["${bg[index]}"]}"),
                                    fit: BoxFit.fill
                                  )
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.40),
                                        Colors.black.withOpacity(0.40)
                                      ]
                                    )
                                  ),
                                  child: Column(                          
                                    children: <Widget>[
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              height: 40,
                                              width: 40,
                                              child: RawMaterialButton(
                                                shape: CircleBorder(),
                                                onPressed: () {
                                                  if(cities.length == 1){
                                                    setState(() {
                                                      dayIndex = -1;
                                                    });
                                                  }else{                                                    
                                                    if(cities.length == 2){ // when only 2 places are left
                                                      setState(() {
                                                        dayIndex = 0;
                                                      });
                                                    }else{ // when more than 2 places are left                                                      
                                                      if(index == cities.length - 1){
                                                        dayIndex -= 1;
                                                      }else{
                                                        dayIndex = index;
                                                      }
                                                    }
                                                  }
                                                  setState(() {
                                                    cities.remove(cities[index]);                                                    
                                                  });                                                  
                                                  print(dayIndex);
                                                  // print("Length of cities list : ${cities.length}");
                                                },                                            
                                                child: Icon(Icons.remove, color: Colors.redAccent,),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: AutoSizeText(
                                          "${cities[index].cityName[0].toUpperCase()}${cities[index].cityName.substring(1).toLowerCase()}, ${cities[index].countryCode}",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 35,
                                            color: Colors.grey[200],
                                            fontWeight: FontWeight.w200,
                                            letterSpacing: 1
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Text(
                                        "${cities[index].finalDate}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.grey[200],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      SizedBox(height: 30,),
                                      Text(
                                        "${cities[index].finalTemp}°C",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 55,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey[200],                                   
                                        ),
                                      ),
                                       Text(
                                        "Feels like : ${cities[index].feelsLike}°C",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.grey[200],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      Text(
                                        "----------------",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 10,
                                          letterSpacing: 1,
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: AutoSizeText(
                                          "${cities[index].description0}",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            color: Colors.grey[200],
                                            fontWeight: FontWeight.w200,
                                            letterSpacing: 1
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "${cities[index].finalLowTemp0}°C / ${cities[index].finalHighTemp0}°C",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      IconButton(
                                        icon: Icon(Icons.refresh, color: Colors.grey[200],),
                                        
                                      )
                                    ],
                                  ),
                                )
                              ),
                            ),
                            
                          );
                        },
                        
                        loop: false,
                        scale: 0.75,
                        viewportFraction: 0.74,
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(                  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                  
                      children: <Widget>[
                        // dayIndex == -1? SizedBox(width: 1,) :
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                              children: <Widget>[
                                Container(
                                  width: dayIndex == -1 ? 0 : 45,
                                  height: dayIndex == -1 ? 0 : 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: dayIndex == -1 ?
                                        AssetImage("assets/c04d.png") :
                                        AssetImage("assets/${weatherIcons["${cities[dayIndex].description0}"]}")
                                    )
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Text(
                                  // "data",
                                  // "${cities[dayIndex].finalLowTemp}°C/${cities[dayIndex].finalHighTemp}°C",
                                  dayIndex == -1 ? "" :
                                  "${cities[dayIndex].finalLowTemp0}°C/${cities[dayIndex].finalHighTemp0}°C", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Text(
                                  dayIndex == -1 ? "" : "Today", 
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 12,
                                    color: Colors.white70
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // dayIndex == -1? SizedBox(width: 1,) :
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: dayIndex == -1 ? 0 : 45,
                                  height: dayIndex == -1 ? 0 : 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: dayIndex == -1 ?
                                        AssetImage("assets/c04d.png") :
                                        AssetImage("assets/${weatherIcons["${cities[dayIndex].description1}"]}")
                                    )
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Text(
                                  // "data",
                                  dayIndex == -1 ? "":
                                  "${cities[dayIndex].finalLowTemp1}°C/${cities[dayIndex].finalHighTemp1}°C", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Text(
                                  dayIndex == -1 ? "" : "Tomorrow", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: "Montserrat",
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // dayIndex == -1? SizedBox(width: 1,) :
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: dayIndex == -1 ? 0 : 45,
                                  height: dayIndex == -1 ? 0 : 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: dayIndex == -1 ?
                                        AssetImage("assets/c04d.png") :
                                        AssetImage("assets/${weatherIcons["${cities[dayIndex].description2}"]}")
                                    )
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Text(
                                  // "data",
                                  dayIndex == -1 ? "" :
                                  "${cities[dayIndex].finalLowTemp2}°C/${cities[dayIndex].finalHighTemp2}°C", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Text(
                                  dayIndex == -1 ? "" : "Next Day", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: "Montserrat",
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    final Weather result = await Navigator.push(
      context,
      PageTransition(child: SearchPage(), type: PageTransitionType.rightToLeftWithFade),      
    );

    if (result != null){
      setState(() {        
        cities.add(result);        
      });
      setState(() {
        cityNames.add(result.cityName);
      });
    }    

    if(dayIndex == -1){
      setState(() {
        dayIndex = 0;
      });
    }

    setState(() {
      bg.add(result.description0);
    });
    
  }
  
  @override
  bool get wantKeepAlive => true;

}