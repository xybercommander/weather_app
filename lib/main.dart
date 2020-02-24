import 'package:flutter/material.dart';
import 'weatherApi.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'searchPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
    "Few clouds" : "c02d.png",
    "Broken clouds" : "c03d.png",
    "Overcast clouds" : "c04d.png",
    "Scattered clouds" : "c02d.png",
    "Unknown Precipitation" : "r01d.png",
    "null" : "c04d.png",
  };


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
                          print(dayIndex);     
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
                                    image: AssetImage("assets/rainyDay.jpg"),
                                    fit: BoxFit.fill
                                  )
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.4),
                                        Colors.black.withOpacity(0.4)
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
                                                  if(cities.isEmpty){
                                                    setState(() {
                                                      dayIndex = -1;
                                                    });
                                                  }else{                                                    
                                                    if(cities.length == 2){ // when only 2 places are left
                                                      setState(() {
                                                        dayIndex = 0;
                                                      });
                                                    }else{ // when more than 2 places are left
                                                      setState(() {
                                                        dayIndex = index;
                                                      });
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
                                            color: Colors.white70,
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
                                          color: Colors.white70,
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
                                          color: Colors.white70                                       
                                        ),
                                      ),
                                       Text(
                                        "Feels like : ${cities[index].feelsLike}°C",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.white70,
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
                                          color: Colors.white70
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
                                            color: Colors.white70,
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
                                          color: Colors.white70
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ),
                            
                          );
                        },
                        loop: false,
                        scale: 0.80,
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
                                  dayIndex == -1 ? "" : "day0", 
                                  style: TextStyle(
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
                                SizedBox(height: 1,),
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
                                  dayIndex == -1 ? "" : "day1", 
                                  style: TextStyle(
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
                                        AssetImage("assets/${weatherIcons["${cities[dayIndex].description2}"]}")
                                    )
                                  ),
                                ),
                                SizedBox(height: 1,),
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
                                  dayIndex == -1 ? "" : "day2", 
                                  style: TextStyle(
                                    color: Colors.white70
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
    }    

    if(dayIndex == -1){
      setState(() {
        dayIndex = 0;
      });
    }
    
  }
  
  @override
  bool get wantKeepAlive => true;

}