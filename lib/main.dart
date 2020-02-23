import 'package:flutter/material.dart';
import 'weatherApi.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'searchPage.dart';
import 'package:page_transition/page_transition.dart';

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

  List<String> displayImages = [];

  int counter = 0;

  List<String> images = [
    "assets/animeMorning.jpg",
    "assets/ClearNightSky.jpg",
    "assets/CloudyDay.jpg",
    "assets/ClearDay.jpg",
    "assets/FirewatchNight.jpg",
  ];
 

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
                        onPressed: () {},
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
                          Navigator.push(context, PageTransition(child: SearchPage(), type: PageTransitionType.rightToLeftWithFade));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => SearchPage(),
                          // ));
                          // await obj.getWeather();
                          // images.shuffle();
                          // if(counter != images.length) {
                          //   displayImages.add(images[0]);
                          //   setState(() {
                          //     counter = displayImages.length - 1;
                          //   });
                          // }  
                        },
                        color: Colors.white60
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(            
                    child: Container(                                    
                      child: Swiper(       
                        onTap: (index) {
                          // print(index);                        
                        },               
                        itemCount: displayImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 300,
                            child: ClipRRect(                       
                              borderRadius: BorderRadius.circular(30),                            
                              child: Container(
                                decoration: BoxDecoration(                                 
                                  image: DecorationImage(                                  
                                    image: AssetImage(displayImages[index]),
                                    fit: BoxFit.fill
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
                                                  displayImages.remove(displayImages[index]);
                                                });
                                                print(displayImages);
                                              },                                            
                                              child: Icon(Icons.remove, color: Colors.redAccent,),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(
                                      "${obj.cityName},${obj.countryCode}",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 35,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w200,
                                        letterSpacing: 1
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    Text(
                                      "${obj.finalDate}",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                    SizedBox(height: 50,),
                                    Text(
                                      "${obj.temp}°C",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 55,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white70                                       
                                      ),
                                    ),
                                     Text(
                                      "Feels like : ${obj.feelsLike}°C",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                  ],
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
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(                  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                  
                      children: <Widget>[
                        Text("day1", style: TextStyle(color: Colors.white60),),
                        Text("day2", style: TextStyle(color: Colors.white60),),
                        Text("day3", style: TextStyle(color: Colors.white60),),
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

  @override
  bool get wantKeepAlive => true;
}