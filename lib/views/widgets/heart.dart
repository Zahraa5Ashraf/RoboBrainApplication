import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../models/chartdata.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/widgets/statisticsCard.dart';

class Heart extends StatefulWidget {
  static List<dynamic> activities = [];

  @override
  State<Heart> createState() => _HeartState();
}

List<ChartData> data = [];
ChartSeriesController? _chartSeriesController;

class _HeartState extends State<Heart> {
  var heartrate = 120.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), updateDataSource);
  }

  void stopTimer() {
    _timer?.cancel();
  }

  int time = 1;
  void updateDataSource(Timer timer) {
    setState(() {
      data.add(ChartData(time++, (math.Random().nextInt(100) + 80)));
      if (data.length > 30) {
        data.removeAt(0);
      }
      _chartSeriesController?.updateDataSource();
    });
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
        axisLineStyle: const AxisLineStyle(
          thickness: 0.1,
          thicknessUnit: GaugeSizeUnit.factor,
        ),
        pointers: <GaugePointer>[
          RangePointer(
            enableAnimation: true,
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
            widget: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/heart hehe.gif'),
                    ),
                  ),
                ),
                Text(
                  heartrate.toString(),
                  style: const TextStyle(
                      fontSize: 45, fontWeight: FontWeight.bold),
                ),
                const Text(
                  ' BPM',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ktextcolor2),
                ),
              ],
            ),
            angle: 90,
            positionFactor: 0.8,
          ),
        ],
      )
    ]);
  }

  Widget getChart() {
    return SfCartesianChart(
      enableAxisAnimation: true,
      margin: const EdgeInsets.all(10),
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        minimum: 1,
        maximum: 30,
        isVisible: true,
        interval: 5,
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        minimum: 60,
        maximum: 200,
        isVisible: true,
        interval: 20,
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),
      series: <ChartSeries<ChartData, int>>[
        SplineAreaSeries<ChartData, int>(
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesController = controller;
          },
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.value,
          yValueMapper: (ChartData data, _) => data.day,
          splineType: SplineType.natural,
          gradient: LinearGradient(
            colors: [
              kPrimary2,
              kPrimaryLightColor.withAlpha(30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        SplineSeries<ChartData, int>(
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesController = controller;
          },
          dataSource: data,
          color: kPrimary2,
          width: 4,
          markerSettings: const MarkerSettings(
            color: kPrimaryColor,
            shape: DataMarkerType.circle,
            borderColor: kPrimary2,
            isVisible: true,
            borderWidth: 3,
          ),
          xValueMapper: (ChartData data, _) => data.value,
          yValueMapper: (ChartData data, _) => data.day,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'Heart Rate',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Measure',
              ),
              Tab(
                text: 'Statistics',
              )
            ],
          ),
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
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: _getRadialGauge(),
                            ),
                            Container(
                              width: 500,
                              height: 223,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/heartbeat.gif'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  //   _chartSeriesController = ChartSeriesController();
                  data = getChartData();
                  startTimer();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Measurments in last 30 days',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: ktextcolor2,
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: getChart(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  stasticsCard(
                                    title: 'Min',
                                    value: '80',
                                  ),
                                  stasticsCard(
                                    title: 'Avg',
                                    value: '120',
                                  ),
                                  stasticsCard(
                                    title: 'Max',
                                    value: '180',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<ChartData> getChartData() {
  return <ChartData>[
    ChartData(1, 150),
    ChartData(2, 120),
    ChartData(3, 120),
    ChartData(4, 177),
    ChartData(5, 124),
    ChartData(10, 150),
    ChartData(12, 60),
    ChartData(13, 90),
    ChartData(20, 120),
    ChartData(25, 123),
    ChartData(30, 130),
  ];
}

Stream<DateTime> getTime() async* {
  DateTime currentTime = DateTime.now();
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield currentTime;
  }
}
