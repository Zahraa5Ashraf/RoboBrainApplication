// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, unnecessary_brace_in_string_interps, empty_catches

import 'package:flutter/material.dart';
import 'package:healthcare/views/global.dart';
import 'package:healthcare/views/widgets/heart.dart';
import 'package:healthcare/views/widgets/blood.dart';
import 'package:healthcare/views/widgets/temprature.dart';
import 'package:healthcare/views/widgets/oxygen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../register.dart';
import '../services/notif_service.dart';

class sensorReading extends StatefulWidget {
  final textcolor;
  final String sensorName;
  final String state;
  final String pic;
  final Color1;
  final Color2;
  final index;

  const sensorReading({
    Key? key,
    required this.textcolor,
    required this.sensorName,
    required this.state,
    required this.Color1,
    required this.Color2,
    required this.pic,
    required this.index,
  }) : super(key: key);

  @override
  State<sensorReading> createState() => _sensorReadingState();
}

var heartint = 100.0;
var tempint = 100.0;
var heart2 = '100.0';
var temp2 = '100.0';
Future sensorupdate(BuildContext cont) async {
  try {
    var url =
        Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/chair/data/55");
    var response = await http.get(
      url,
      headers: {
        'content-Type': 'application/json',
        "Authorization": "Bearer ${token}"
      },
    );
    /*remove this comments*/
    var data = json.decode(response.body);
    heartint = data["pulse_rate"];
    tempint = data["temperature"];
    heart2 = data["pulse_rate"].toString();
    temp2 = data["temperature"].toString();
    /*remove this comments*/

    // heart2 = '100';
    // temp2 = '40';
    // heartint = 100;
    // tempint = 40;
    if (heartint > 90 || heartint < 50) {
      NotificationService().showNotification(
          title: 'Heart Emergency',
          body: 'Heart Rate is high Go to the hospital immediately!');
    }
    if (tempint > 37 || tempint < 35) {
      NotificationService().showNotification(
          title: 'Temprature Emergency',
          body: 'body Temp Rate is high Call the doctor immediately!');
    }
  } catch (e) {}
}

class _sensorReadingState extends State<sensorReading> {
  List<Widget> sensors = [
    Heart(),
    temprature(),
    const blood(),
    oxygen(),
  ];

  @override
  Widget build(BuildContext context) {
    sensorupdate(context);
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            Token.heartreading = heart2;
            Token.tempreading = temp2;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => sensors[int.parse(widget.index)],
            ),
          );
        },
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [widget.Color1, widget.Color2]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.pic),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.sensorName,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.textcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // child: ListTile(
          //   leading: ClipRRect(
          //     borderRadius: BorderRadius.circular(12),
          //     child: Container(
          //       padding: EdgeInsets.all(5),
          //       color: Color,
          //       child: Image.asset(
          //         pic,
          //         height: 70.0,
          //         width: 70,
          //       ),
          //     ),
          //   ),
          //   title: Text(
          //     sensorName,
          //     style: TextStyle(
          //       color: Colors.grey[600],
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20,
          //     ),
          //   ),
          //   subtitle: Text(
          //     state,
          //     style: TextStyle(
          //       color: Colors.grey[500],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
