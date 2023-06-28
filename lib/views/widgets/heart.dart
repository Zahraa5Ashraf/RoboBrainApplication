import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:healthcare/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/HomePage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:healthcare/views/global.dart';

import '../../components/button.dart';
import '../../models/chartdata.dart';
import '../login/components/body.dart';

class heart extends StatefulWidget {
  static List<dynamic> activities = [];

  // const heart({super.key});

  @override
  State<heart> createState() => _heartState();
}

var heartrate = 120.0;
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
//   test = data["heart_rate"].toString();
//   if (data["heart_rate"] < 120) {
//     print('patient died');
//   }
//   print(data["heart_rate"]);
// }
late List<chartData> data;

class _heartState extends State<heart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = [
      chartData(1, 150),
      chartData(2, 120),
      chartData(3, 120),
      chartData(4, 177),
      chartData(5, 124),
      chartData(10, 150),
      chartData(12, 60),
      chartData(13, 90),
      chartData(20, 120),
      chartData(25, 123),
      chartData(30, 130),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // update(context);

    // DioHelper.getData(url: 'activity/', query: {'': ''}).then((value) {
    //   print(value!.data['type'].toString());
    //   test = value.data['type'].toString();
    // }).catchError((error) {
    //   print(error.toString());
    // });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            //replace with our own icon data.
          ),
          title: Text(
            'Heart Rate',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              text: 'Measure',
            ),
            Tab(
              text: 'Statistics',
            )
          ]),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          //  left: 25,
                          // right: 25,
                        ),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: _getRadialGauge(),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 500,
                                height: 223,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/heartbeat.gif'),
                                )),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(30.0),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: buttonWidget(
                              //           label: 'Update',
                              //           press: () {},
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 20,
                              //       ),
                              //       Expanded(
                              //         child: buttonWidget(
                              //           label: 'Plot',
                              //           press: () {},
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          //  left: 25,
                          // right: 25,
                        ),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Container(
                                child: Center(
                                  child: getChart(),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Min',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ktextcolor2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '80',
                                        style: TextStyle(
                                            fontSize: 20, color: ktextcolor2),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Max',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ktextcolor2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '160',
                                        style: TextStyle(
                                            fontSize: 20, color: ktextcolor2),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Avg',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: ktextcolor2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '120',
                                        style: TextStyle(
                                            fontSize: 20, color: ktextcolor2),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          minimum: 60,
          maximum: 180,
          radiusFactor: 0.80,
          endAngle: 90,
          startAngle: 90,
          showLabels: false,
          showTicks: false,
          axisLineStyle: AxisLineStyle(
            thickness: 0.1,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              enableAnimation: true,
              // cornerStyle: CornerStyle.bothCurve,
              value: heartrate,
              width: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              gradient: const SweepGradient(colors: <Color>[
                Color(0xFF753A88),
                Color(0xFFCC2B5E),
              ], stops: <double>[
                0.25,
                0.75
              ]),
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/heart hehe.gif'),
                      )),
                    ),
                    Text('${heartrate.toString()}',
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold)),
                    Text(' BPM',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ktextcolor2)),
                  ],
                )),
                angle: 90,
                positionFactor: 0.8)
          ])
    ]);
  }
}

Widget getChart() {
  return SfCartesianChart(
    enableAxisAnimation: true,
    margin: EdgeInsets.all(10),
    borderWidth: 0,
    borderColor: Colors.transparent,
    plotAreaBorderWidth: 0,
    primaryXAxis: NumericAxis(
        minimum: 1,
        maximum: 30,
        isVisible: true,
        interval: 5,
        borderWidth: 0,
        borderColor: Colors.transparent),
    primaryYAxis: NumericAxis(
        minimum: 60,
        maximum: 200,
        isVisible: true,
        interval: 20,
        borderWidth: 0,
        borderColor: Colors.transparent),
    series: <ChartSeries<chartData, int>>[
      SplineAreaSeries(
          dataSource: data,
          xValueMapper: (chartData data, _) => data.value,
          yValueMapper: (chartData data, _) => data.day,
          splineType: SplineType.natural,
          gradient: LinearGradient(
            colors: [
              kPrimary2,
              kPrimaryLightColor.withAlpha(30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      SplineSeries(
        dataSource: data,
        color: kPrimary2,
        width: 4,
        markerSettings: MarkerSettings(
          color: kPrimaryColor,
          shape: DataMarkerType.circle,
          borderColor: kPrimary2,
          isVisible: true,
          borderWidth: 3,
        ),
        xValueMapper: (chartData data, _) => data.value,
        yValueMapper: (chartData data, _) => data.day,
      ),
    ],
  );
}

Stream<DateTime> getTime() async* {
  DateTime currentTime = DateTime.now();
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    yield currentTime;
  }
}
