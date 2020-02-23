import 'package:flutter/material.dart';
import 'weatherApi.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Weather obj = Weather(cityName: "Kolkata");
  // List<Weather> places = [
  //   Weather(cityName: "Kolkata"),
  //   Weather(cityName: "NewDelhi"),
  //   Weather(cityName: "Chennai"),
  //   Weather(cityName: "Mumbai"),
  //   Weather(cityName: "Tokyo"),
  // ];

  List<String> images = [
    "assets/animeMorning.jpg",
    "assets/aestheticEvening.jpg",
    "assets/animeMorning2.jpg",
    "assets/DawnAnime.jpg",
    "assets/FirewatchNight.jpg",
  ];

  List<String> displayImages = [];

  int counter = 0;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              
              image: AssetImage("assets/bgimg.jpg"),
              fit: BoxFit.fill
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
                        color: Colors.white60
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        await obj.getWeather();
                        images.shuffle();
                        if(counter != images.length) {
                          displayImages.add(images[0]);
                          setState(() {
                            counter = displayImages.length - 1;
                          });
                        }  
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
                        print(index);                        
                      },               
                      itemCount: displayImages.length,
                      itemBuilder: (context, index) {
                        return Container(
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
                                  Text("data"),
                                  Text("data"),
                                  Text("data"),
                                ],
                              )
                            ),
                          ),
                          
                        );
                      },
                      loop: false,
                      scale: 0.8,
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
      )
       
    );
  }

  Widget photoCard(int index) {
    return Container(
      width: 300,
      child: ClipRRect(                      
        borderRadius: BorderRadius.circular(30),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.fill
            )
          ),
        )
      ),
    );
  }  

}