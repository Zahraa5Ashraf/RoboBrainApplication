//import 'dart:convert';
import 'package:healthcare/constants.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcare/views/HomePage.dart';
import 'package:healthcare/views/widgets/statisticsCard.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../components/button.dart';
import '../login/components/body.dart';

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
      padding: const EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/animatedbackground.gif'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'Temprature',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/animatedbackground.gif'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
              // top: 30.0,
              ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: ClipRRect(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 25,
                    //  left: 25,
                    // right: 25,
                  ),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: _getRadialGauge(),
                              ),
                              const Column(
                                children: [
                                  stasticsCard(
                                    title: 'Max',
                                    value: '46',
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  stasticsCard(
                                    title: 'Avg',
                                    value: '37',
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  stasticsCard(
                                    title: 'Min',
                                    value: '35',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
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
                        const SizedBox(
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
        majorTickStyle: const LinearTickStyle(length: 20),
        axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
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
                  shape: const CircleBorder(),
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
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )),
        ],
        axisTrackStyle: const LinearAxisTrackStyle(
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
