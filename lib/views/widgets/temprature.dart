import 'dart:async';
import 'dart:convert';
// ignore_for_file: camel_case_types

import 'package:healthcare/constants.dart';
import 'package:healthcare/views/services/notif_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcare/views/widgets/statisticsCard.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../global.dart';
import '../login/components/body.dart';

class temprature extends StatefulWidget {
  const temprature({super.key});
  //const temprature({super.key});

  @override
  State<temprature> createState() => _tempratureState();
}

var tempratureValue = 37.0;

class _tempratureState extends State<temprature> {
  var min = 35.0;
  var max = 39.0;
  Timer? _timer;
  Future<void> sensorupdate(Timer timer) async {
    try {
      var url = Uri.parse("${Token.server}chair/data/${Token.selectedchairid}");
      var response = await http.get(
        url,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      var data = json.decode(response.body);
      if (mounted) {
        setState(() {
          tempratureValue = data["temperature"];
          if (tempratureValue < Token.tempreading) {
            min = tempratureValue;
          }
          if (tempratureValue > Token.tempreading) {
            max = tempratureValue;
          }
          Token.tempreading = tempratureValue;

          if (tempratureValue > 37.0 || tempratureValue < 35.0) {
            NotificationService().showNotification(
                title: 'Temprature Emergency',
                body: 'body Temp Rate is high Call the doctor immediately!');
            Token.emergencyStatetemp = true;
            Token.tempreading = tempratureValue;
          } else {
            Token.emergencyStatetemp = false;
          }
        });
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), sensorupdate);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    if (Token.emergencyStatetemp) {
      postnotification('TempRate', Token.tempreading,
          int.parse(Token.selectedchairid.toString()));
    }
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: const BoxDecoration(
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
                              Column(
                                children: [
                                  stasticsCard(
                                    title: 'Max',
                                    value: '$max',
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const stasticsCard(
                                    title: 'Normal',
                                    value: '37',
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  stasticsCard(
                                    title: 'Min',
                                    value: '$min',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
              value: Token.tempreading,
              child: SizedBox(
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
                        Token.tempreading.toString(),
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

  Future postnotification(String sensor, double value, int chairid) async {
    try {
/**FOR TEST */
      Map<String, dynamic> body = {
        "sensor": sensor,
        "value": value,
        "chair_id": chairid,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url2 = Uri.parse('${Token.server}caregiver/notification');
      var response2 = await http.post(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": " Bearer $token"
        },
        body: jsonBody,
        encoding: encoding,
      );
      return response2;
    } catch (e) {
      // print error
    }
  }
}
