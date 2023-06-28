import 'dart:convert';
import 'package:healthcare/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/HomePage.dart';
import 'package:healthcare/views/global.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../components/button.dart';
import '../home.dart';
import '../login/components/body.dart';
import '../register.dart';

class temprature extends StatefulWidget {
  static List<dynamic> activities = [];
  //const temprature({super.key});

  @override
  State<temprature> createState() => _tempratureState();
}

var tempratureValue = 37.0;

class _tempratureState extends State<temprature> {
  @override
  Widget build(BuildContext context) {
    //update(context);

    // DioHelper.getData(url: 'activity/', query: {'': ''}).then((value) {
    //   print(value!.data['type'].toString());
    //   test = value.data['type'].toString();
    // }).catchError((error) {
    //   print(error.toString());
    // });
    return Container(
      padding: EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/animatedbackground.gif'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          Age: globalage,
                          Username: globalusername,
                          Gender: globalgender,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Temprature",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 25,
                    //  left: 25,
                    // right: 25,
                  ),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Center(
                          child: Container(
                            child: _getRadialGauge(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: buttonWidget(
                                  label: 'Update',
                                  press: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    return SfLinearGauge(
        minimum: 20.0,
        maximum: 45.0,
        orientation: LinearGaugeOrientation.vertical,
        majorTickStyle: LinearTickStyle(length: 20),
        axisLabelStyle: TextStyle(fontSize: 12.0, color: Colors.black),
        markerPointers: [
          // LinearShapePointer(
          //   enableAnimation: true,
          //   value: tempratureValue,
          // ),
          LinearWidgetPointer(
              enableAnimation: true,
              value: tempratureValue,
              child: Container(
                width: 34,
                height: 34,
                child: Material(
                  elevation: 4, // Set the desired elevation value
                  shadowColor: Colors.black, // Set the desired shadow color
                  shape: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimary2,
                      border: Border.all(
                        color: Colors.white, // Set the desired border color
                        width: 1, // Set the desired border width
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${tempratureValue.toString()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )),
        ],
        axisTrackStyle: LinearAxisTrackStyle(
            color: Colors.cyan,
            gradient: LinearGradient(colors: <Color>[
              Color(0xFFCC2B5E),
              Color(0xFF753A88),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            edgeStyle: LinearEdgeStyle.bothCurve,
            thickness: 15.0,
            borderColor: Colors.grey));
  }
}
