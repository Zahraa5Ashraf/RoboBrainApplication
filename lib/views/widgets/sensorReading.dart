// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, unnecessary_brace_in_string_interps, empty_catches, file_names

import 'package:flutter/material.dart';
import 'package:healthcare/views/global.dart';

import 'package:healthcare/views/widgets/heart.dart';
import 'package:healthcare/views/widgets/notificationtab.dart';
import 'package:healthcare/views/widgets/temprature.dart';
import 'package:healthcare/views/widgets/oxygen.dart';

import '../HomePage.dart';



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



class _sensorReadingState extends State<sensorReading> {


  List<Widget> sensors = [
    const Heart(),
    const temprature(),
    const notificationtab(),
    const oxygen(),
  ];

  

  @override
  void initState() {
    

    super.initState();}
   

    @override
    Widget build(BuildContext context) {
      return Card(
        child: InkWell(
          onTap: () {
            setState(() {
              Token.heartreading = heartdouble;
              Token.tempreading = tempdouble;
              Token.oxygenreading = oxratedouble;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sensors[int.parse(widget.index)],
              ),
            );
          },
          child: Container(
            height: 150,
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
                  radius: 38,
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
          ),
        ),
      );
    }
  }

