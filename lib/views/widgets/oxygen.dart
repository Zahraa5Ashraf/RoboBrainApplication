//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/widgets/statisticsCard.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class oxygen extends StatefulWidget {
  static List<dynamic> activities = [];

  // const oxygen({super.key});

  @override
  State<oxygen> createState() => _oxygenState();
}

var _volumeValue = 50.0;
var date = '11 FEBRUARY';
// Future update(BuildContext cont) async {
//   Map<String, dynamic> body = {
//     "email": "",
//     "password": "",
//   };
//   String jsonBody = json.encode(body);
//   final encoding = Encoding.getByName('utf-8');

//   var url = Uri.parse("https://304d-197-133-196-239.eu.ngrok.io/chair/data");
//   var response = await http.get(
//     url,
//     headers: {
//       'content-Type': 'application/json',
//       "Authorization": "Bearer ${token}"
//     },
//   );

//   var data = json.decode(response.body);
//   print(data);
//   test = data["oxygen_rate"].toString();
//   if (data["oxygen_rate"] < 120) {
//     print('patient died');
//   }
//   print(data["oxygen_rate"]);
// }

class _oxygenState extends State<oxygen> {
  @override
  Widget build(BuildContext context) {
    // update(context);

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
                        '  SO2 = ${_volumeValue.toString()} 💧',
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          stasticsCard(
                            title: 'Min',
                            value: '50',
                          ),
                          stasticsCard(
                            title: 'Avg',
                            value: '90',
                          ),
                          stasticsCard(
                            title: 'Max',
                            value: '100',
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
          axisLineStyle: AxisLineStyle(
              cornerStyle: CornerStyle.bothFlat,
              color: Colors.black12,
              thickness: 12),
          pointers: <GaugePointer>[
            RangePointer(
                enableAnimation: true,
                value: _volumeValue,
                cornerStyle: CornerStyle.bothFlat,
                width: 12,
                sizeUnit: GaugeSizeUnit.logicalPixel,
                color: kPrimaryColor,
                gradient: const SweepGradient(
                    colors: <Color>[kPrimaryLightColor, kPrimary2],
                    stops: <double>[0.25, 0.75])),
            MarkerPointer(
                enableAnimation: true,
                value: _volumeValue,
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
                widget: Text(_volumeValue.ceil().toString() + '%',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: kPrimary2)))
          ])
    ]);
  }
}

Stream<DateTime> getTime() async* {
  DateTime currentTime = DateTime.now();
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield currentTime;
  }
}
