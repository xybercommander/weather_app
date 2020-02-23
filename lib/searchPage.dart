import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   title: Text("data"),
      //   centerTitle: true,
      //   elevation: 0,
      // ),

      resizeToAvoidBottomInset: false,
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
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.3)
                ]
              )
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,
                sigmaY: 3
              ),
              child: SafeArea(
                child: Container(
                  color: Colors.black.withOpacity(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,                  
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.white60
                            ),
                            SizedBox(width: 1,)
                          ],
                        ),
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.30),
                                Colors.black.withOpacity(0.30),
                              ]
                            ),
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),                    
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search by City Name",                                      
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontFamily: "Montserrat",
                                      fontSize: 20
                                    )
                                  ),
                                  cursorColor: Colors.orange[100],                                  
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: "Montserrat",
                                    fontSize: 20
                                  ),
                                  // controller: mycontroller,
                                  onSubmitted: (String str) {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(width: 1,),
                          Stack(
                            children: <Widget>[
                              SpinKitChasingDots(
                                size: 80,
                                color: Colors.white.withOpacity(0.3),
                              
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.30),
                                      Colors.black.withOpacity(0.30),
                                    ]
                                  ),
                                  borderRadius: BorderRadius.circular(35)
                                ),
                                height: 60,
                                width: 60,
                                child: RawMaterialButton(
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    
                                  },                                            
                                  child: Icon(Icons.search, color: Colors.white60),                                  
                                ),
                              ),                              
                            ],
                          ),
                          SizedBox(width: 1,),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}