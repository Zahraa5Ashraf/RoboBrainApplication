// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare/views/services/getfcm.dart';
import 'package:healthcare/views/services/notif_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/global.dart';
import 'package:healthcare/views/login/components/body.dart';

import 'package:healthcare/views/map.dart';
import 'package:healthcare/views/services/globalfunction.dart';

import '../main.dart';
import 'home.dart';
import 'profile screen/proflle_screen.dart';

class HomePage extends StatefulWidget {
  // const HomePage({super.key});
  final String Username;
  final String Age;
  final String Gender;

  const HomePage({
    super.key,
    required this.Username,
    required this.Age,
    required this.Gender,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

var heartdouble = 70.0;
var tempdouble = 37.0;

var oxratedouble = 50.0;
final List<dynamic> notifications = [];

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  Timer? _timer2;

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
    getcurrentLocation();

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

  Color iconColor = Colors.white;

  //////////////////////////new code
  int pageIndex = 0;
  int currentIndex = 0;
  /////////////////new code
  List<Widget> screens = [
    home(
      age: globalage,
      gender: globalgender,
      username: globalusername,
    ),
    const map(),
    const profile(),
  ];

  void navigateToTab(int index) async {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //update(context);
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/animatedbackground.gif',
          ),
          fit: BoxFit.cover,
          //fit: BoxFit.cover
        ),
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [kPrimaryLightColor, Colors.white]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: currentIndex,
            elevation: 10,
            backgroundColor: Colors.white,
            onTap: navigateToTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.house_alt_fill,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.location_solid,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Icon(
                          CupertinoIcons.person_fill,
                        ),
                      ]),
                  label: ''),
            ]),
        body: screens[currentIndex],
      ),
    );
  }
}
