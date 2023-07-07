// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, unnecessary_brace_in_string_interps, empty_catches, file_names

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare/views/global.dart';
import 'package:healthcare/views/services/globalfunction.dart';
import 'package:healthcare/views/widgets/heart.dart';
import 'package:healthcare/views/widgets/notificationtab.dart';
import 'package:healthcare/views/widgets/temprature.dart';
import 'package:healthcare/views/widgets/oxygen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';
import '../register.dart';
import '../services/getfcm.dart';
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

var heartdouble = 70.0;
var tempdouble = 37.0;

var oxratedouble = 50.0;
final List<dynamic> notifications = [];

class _sensorReadingState extends State<sensorReading> {
  Timer? _timer;
  Timer? _timer2;

  List<Widget> sensors = [
    const Heart(),
    const temprature(),
    const notificationtab(),
    const oxygen(),
  ];

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
//      print(data);
      if (mounted) {
        setState(() {
          heartdouble = data["pulse_rate"];
          tempdouble = data["temperature"];
          oxratedouble = data["oximeter"];

          if (heartdouble > 160.0 || heartdouble < 50.0) {
            showNotification('Heart Emergency',
                'Heart Rate is high Go to the hospital immediately!');
            Token.emergencyStateheart = true;
            Token.heartreading = heartdouble;
          } else {
            Token.emergencyStateheart = false;
          }

          if (tempdouble > 37.0 || tempdouble < 35.0) {
            NotificationService().showNotification(
                title: 'Temprature Emergency',
                body: 'body Temp Rate is high Call the doctor immediately!');
            Token.emergencyStatetemp = true;
            Token.tempreading = tempdouble;
          } else {
            Token.emergencyStatetemp = false;
          }

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

  Future<void> checkEmergency(Timer timer2) async {
    try {
      if (Token.emergencyStateheart) {
        postnotification('HeartRate', Token.heartreading,
            int.parse(Token.selectedchairid.toString()));
      }
      if (Token.emergencyStateoxy) {
        postnotification('OxygRate', Token.oxygenreading,
            int.parse(Token.selectedchairid.toString()));
        //print('posted');
      }
      if (Token.emergencyStatetemp) {
        postnotification('TempRate', Token.tempreading,
            int.parse(Token.selectedchairid.toString()));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();

    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), sensorupdate);
    _timer2 = Timer.periodic(const Duration(seconds: 10), checkEmergency);
  }

  void stopTimer() {
    _timer?.cancel();
    _timer2?.cancel();
  }

  @override
  void initState() {
    startTimer();

    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //   print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification(String title, String desc) async {
    String? fcmKey = await getFcmToken();
    print('fcm: $fcmKey');
    setState(() {
      Token.counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        desc,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

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
