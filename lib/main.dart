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
                          if(dayIndex == -1){
                            setState(() {
                              dayIndex = 0;
                            });
                          }
                          _awaitReturnValueFromSecondScreen(context);                          
                        },
                        color: Colors.white60
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Expanded(            
                    child: Container(                                    
                      child: Swiper(                             
                        onIndexChanged: (value) {
                           
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
                                                  setState(() {
                                                    cities.remove(cities[index]);                                                    
                                                  });
                                                  if(cities.length == 0){
                                                    setState(() {
                                                      dayIndex = -1;
                                                    });
                                                  }
                                                  print(dayIndex);
                                                  print("Length of cities list : ${cities.length}");
                                                },                                            
                                                child: Icon(Icons.remove, color: Colors.redAccent,),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: AutoSizeText(
                                          "${cities[index].cityName[0].toUpperCase()}${cities[index].cityName.substring(1)}, ${cities[index].countryCode}",
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
                                      Text(
                                        "${cities[index].description}",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          letterSpacing: 1,
                                          color: Colors.white70
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "${cities[index].finalLowTemp}°C / ${cities[index].finalHighTemp}°C",
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
                        scale: 0.85,
                        viewportFraction: 0.72,
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
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
                                Icon(Icons.cloud, color: Colors.white70,),
                                SizedBox(height: 2,),
                                Text(
                                  // "data",
                                  // "${cities[dayIndex].finalLowTemp}°C/${cities[dayIndex].finalHighTemp}°C",
                                  dayIndex == -1 ? "No Data" :
                                  "${cities[dayIndex].finalLowTemp}°C/${cities[dayIndex].finalHighTemp}°C", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Text("day0", style: TextStyle(color: Colors.white70),),
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
                                Icon(Icons.cloud, color: Colors.white70,),
                                SizedBox(height: 1,),
                                Text(
                                  // "data",
                                  dayIndex == -1 ? "No Data":
                                  "${cities[dayIndex].finalLowTemp}°C/${cities[dayIndex].finalHighTemp}°C", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Text("day1", style: TextStyle(color: Colors.white70),),
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
                                Icon(Icons.cloud, color: Colors.white70,),
                                SizedBox(height: 1,),
                                Text(
                                  // "data",
                                  dayIndex == -1 ? "No Data" :
                                  "${cities[dayIndex].finalLowTemp}°C/${cities[dayIndex].finalHighTemp}°C", 
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(height: 1,),
                                Text("day2", style: TextStyle(color: Colors.white70),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
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
      PageTransition(child: SearchPage(), type: PageTransitionType.rightToLeftWithFade)
    );

    if (result != null){
      setState(() {        
        cities.add(result);        
      });
    }    
    
  }
  
  @override
  bool get wantKeepAlive => true;

}