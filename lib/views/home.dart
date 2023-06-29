import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/widgets/sensorReading.dart';
//import 'package:http/http.dart' as http;

//import 'dart:convert';
import 'package:healthcare/views/global.dart';

class home extends StatefulWidget {
//  const home({super.key});
  final String username;
  final String age;
  final String gender;

  home({
    required this.username,
    required this.age,
    required this.gender,
  });

  @override
  State<home> createState() => _homeState();
}

var text_color = Token.text;

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 15,
            ),
            child: Column(children: [
              //greetings
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        //hello message
                                        'Hi, ${widget.username} !',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //date
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.age} , ${widget.gender}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          // fontWeight: FontWeight.,
                                          fontFamily: 'Kanit',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  'https://raw.githubusercontent.com/Zahraa5Ashraf/flutter/main/new%20logo%20finalllllllyyyy.jpg'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Notification
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.blueGrey[600],
                  //       borderRadius: BorderRadius.circular(15)),
                  //   padding: EdgeInsets.all(12.0),
                  //   child: IconButton(
                  //       color: iconColor,
                  //       icon: Icon(
                  //         Icons.update,
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           if (iconColor == Colors.white) {
                  //             iconColor = Colors.amber;
                  //           } else {
                  //             iconColor = Colors.white;
                  //           }
                  //         });
                  //       }),
                  // )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //  search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    // TextField(
                    //   controller: _searchController,
                    //   decoration: InputDecoration(
                    //       hintText: 'Search...',
                    //       // Add a clear button to the search bar
                    //       suffixIcon: IconButton(
                    //         icon: Icon(Icons.delete_outline_rounded),
                    //         onPressed: () => _searchController.clear(),
                    //       ),
                    //       prefixIcon: IconButton(
                    //         icon: Icon(Icons.search),
                    //         onPressed: () {
                    //           // Perform the search here
                    //         },
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //       )),
                    // ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
            ]),
          ),
          // SizedBox(
          //   height: 15,
          // ),

          //bottom layer
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 25,
                  left: 25,
                  right: 25,
                ),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      //medical state heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Medical Status  ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      //list view of sensor readings
                      Expanded(
                        child: GridView.count(
                          primary: false,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          childAspectRatio: (1 / 1.5),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          children: [
                            sensorReading(
                              index: '0',
                              Color1: kPrimaryLightColor,
                              Color2: Colors.white,
                              textcolor: //Colors.grey[600],
                                  text_color,
                              pic:
                                  'https://raw.githubusercontent.com/Zahraa5Ashraf/flutter/main/heart-rate.png',
                              sensorName: 'Heart Rate',
                              state: '70-80 Safe',
                            ),
                            sensorReading(
                              index: '1',
                              Color1: kPrimaryLightColor,
                              Color2: Colors.white,
                              textcolor: text_color, // Colors.grey[600],
                              pic:
                                  'https://raw.githubusercontent.com/Zahraa5Ashraf/flutter/main/temperature.png',
                              sensorName: 'Temprature',
                              state: '70-80  Safe',
                            ),
                            sensorReading(
                              index: '2',
                              Color1: kPrimaryLightColor,
                              Color2: Colors.white,
                              textcolor: Colors.grey[600],
                              pic:
                                  'https://raw.githubusercontent.com/Zahraa5Ashraf/flutter/main/location.jpg',
                              sensorName: 'Internal map',
                              state: '180-190  Dangerous',
                            ),
                            sensorReading(
                              index: '3',
                              Color1: kPrimaryLightColor,
                              Color2: Colors.white,
                              textcolor: Colors.grey[600],
                              pic:
                                  'https://raw.githubusercontent.com/Zahraa5Ashraf/flutter/main/oxygen-mask.png',
                              sensorName: 'Oxygen-Level',
                              state: '70-80  Safe',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
