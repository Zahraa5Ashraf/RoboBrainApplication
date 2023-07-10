import 'dart:async';
import 'dart:convert';
import 'package:healthcare/views/HomePage.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/widgets/statisticsCard.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../global.dart';
import '../login/components/body.dart';
import '../services/notif_service.dart';

class oxygen extends StatefulWidget {
  const oxygen({super.key});

  // const oxygen({super.key});

  @override
  State<oxygen> createState() => _oxygenState();
}

class _oxygenState extends State<oxygen> {
  var min = 95.0;
  var max = 100.0;
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
          oxratedouble = data["oximeter"];
          if (oxratedouble < Token.oxygenreading) {
            min = oxratedouble;
          }
          if (oxratedouble > Token.oxygenreading) {
            max = oxratedouble;
          }
          Token.oxygenreading = oxratedouble;

          if (oxratedouble < 95.0) {
            NotificationService().showNotification(
                title: 'Oxygen rate Emergency',
                body: 'Oxygen rate is low Call the doctor immediately!');
            Token.emergencyStateoxy = true;
            Token.oxygenreading = oxratedouble;
          } else {
            Token.emergencyStateoxy = false;
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
    if (Token.emergencyStateoxy) {
      postnotification('OxygRate', Token.oxygenreading,
          int.parse(Token.selectedchairid.toString()));
      //print('posted');
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'Oxygen Rate',
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
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '  SO2 = ${Token.oxygenreading.toString()} 💧',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: ktextcolor2,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(child: _getRadialGauge()),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          stasticsCard(
                            title: 'Min',
                            value: '$min',
                          ),
                          const stasticsCard(
                            title: 'Normal',
                            value: '90',
                          ),
                          stasticsCard(
                            title: 'Max',
                            value: '$max',
                          ),
                        ],
                      ),
                    ],
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
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          minimum: 0,
          maximum: 100,
          startAngle: 270,
          endAngle: 270,
          showLabels: false,
          showTicks: false,
          radiusFactor: 0.6,
          axisLineStyle: const AxisLineStyle(
              cornerStyle: CornerStyle.bothFlat,
              color: Colors.black12,
              thickness: 12),
          pointers: <GaugePointer>[
            RangePointer(
                enableAnimation: true,
                value: Token.oxygenreading,
                cornerStyle: CornerStyle.bothFlat,
                width: 12,
                sizeUnit: GaugeSizeUnit.logicalPixel,
                color: kPrimaryColor,
                gradient: const SweepGradient(
                    colors: <Color>[kPrimaryLightColor, kPrimary2],
                    stops: <double>[0.25, 0.75])),
            MarkerPointer(
                enableAnimation: true,
                value: Token.oxygenreading,
                enableDragging: true,
                //   onValueChanged: onVolumeChanged,
                markerHeight: 20,
                markerWidth: 20,
                markerType: MarkerType.circle,
                color: kPrimary2,
                borderWidth: 2,
                borderColor: Colors.white54)
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 90,
                axisValue: 5,
                positionFactor: 0.1,
                widget: Text('${Token.oxygenreading.ceil()}%',
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: kPrimary2)))
          ])
    ]);
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

Stream<DateTime> getTime() async* {
  DateTime currentTime = DateTime.now();
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield currentTime;
  }
}
