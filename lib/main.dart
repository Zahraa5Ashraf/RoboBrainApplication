// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/views/Welcome.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/login/components/body.dart';
import 'package:healthcare/views/services/globalfunction.dart';

import 'package:healthcare/views/services/notif_service.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'dart:convert';
import '/views/global.dart';
import 'package:healthcare/network/dio_helper.dart';
import 'package:healthcare/views/services/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/theme.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager workmanager = Workmanager();
  workmanager.executeTask((task, inputData) async {
    switch (task) {
      case "fetchBackground":
        Future<void> sensorcheck() async {
          var sensorheartdouble = 0.0;
          var sensortempdouble = 0.0;
          var sensoroxratedouble = 0.0;
          try {
            for (int chairParcodeId in Token.chairParcodeIds) {
              var url = Uri.parse("${Token.server}chair/data/$chairParcodeId");

              var response = await http.get(
                url,
                headers: {
                  'content-Type': 'application/json',
                  "Authorization": "Bearer $token"
                },
              );
              var data = json.decode(response.body);
              print(data);

              sensorheartdouble = data["pulse_rate"];
              sensortempdouble = data["temperature"];
              sensoroxratedouble = data["oximeter"];

              if (sensorheartdouble > 160.0 || sensorheartdouble < 50.0) {
                sendNotification(
                    '${Token.devicetokeennn}',
                    'Chair ID $chairParcodeId',
                    'Heart Rate Emergency, value =$sensorheartdouble');
                postnotification(
                    'HeartRate', sensorheartdouble, chairParcodeId);
                print('heart emergency');
              }
              if (sensortempdouble > 37.0 || sensortempdouble < 35.0) {
                sendNotification(
                    '${Token.devicetokeennn}',
                    'Chair ID $chairParcodeId',
                    'Tempratue Emergency, value =$sensortempdouble');
                postnotification('TempRate', sensortempdouble, chairParcodeId);
                print('temp emergency');
              }
              if (sensoroxratedouble < 94) {
                sendNotification(
                    '${Token.devicetokeennn}',
                    'Chair ID $chairParcodeId',
                    'Oxygen Emergency, value =$sensoroxratedouble');
                postnotification(
                    'OxygRate', sensoroxratedouble, chairParcodeId);
                print('oxygen emergency');
              }
            }
          } catch (e) {
            // print(e.toString());
          }
        }
        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  Workmanager workmanager = Workmanager();
  workmanager.initialize(callbackDispatcher);
  workmanager.registerPeriodicTask("fetchBackgroundTask", "fetchBackground",
      frequency: Duration(minutes: 1));
  NotificationService().initNotification();
  runApp(const healthcare());
}

class healthcare extends StatefulWidget {
  const healthcare({super.key});

  State<healthcare> createState() => _healthcareState();
}

void registerPeriodicTask() {
  try {
    Workmanager().registerPeriodicTask(
      "task",
      "started",
      initialDelay: Duration(seconds: 10),
    );
  } catch (e) {
    print(e.toString());
  }
}

class _healthcareState extends State<healthcare> {
  //token to stay logged in
  void getinfo() async {
    try {
      var url2 = Uri.parse("${Token.server}caregiver/info");
      var response2 = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      var data2 = json.decode(response2.body);
      print(response2.statusCode);
      setState(() {
        Token.caregiverid = data2["id".toString()];
        Token.username = data2["username".toString()];
        Token.first_nameuser = data2["first_name".toString()];
        Token.last_nameuser = data2["last_name".toString()];
        Token.emailuser = data2["email".toString()];
        Token.ageuser = data2["age".toString()];
      });
    } catch (e) {
      // print(e.toString());
    }
  }

  gettokenfcm() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      Token.deviceToken = (await messaging.getToken())!;
      print('FCM Token: ${Token.deviceToken}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    try {
      Workmanager().registerPeriodicTask(
        "task",
        "started",
        initialDelay: Duration(seconds: 10),
      );
    } catch (e) {
      print(e.toString());
    }
    initWorkManager(); // Initialize Workmanager

    super.initState();
    checkLoginStatus();
    gettokenfcm();
  }

/**WORK MANAGER */
  void initWorkManager() {
    Workmanager().initialize(
      callbackDispatcher, // The callback method that will be executed when the task is triggered
    );
    registerPeriodicTask(); // Register the periodic task
  }

/**WORK MANAGER */
  var Tokenid;
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    Tokenid = prefs.get('token');
    if (Tokenid != null) {
      setState(() {
        token = Tokenid;
      });
      getinfo();
    }
    return Tokenid;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) => MaterialApp(
        title: 'healthcare',
        theme: AppTheme(context).initTheme(),
        debugShowCheckedModeBanner: false,
        home: Tokenid == null ? login() : SplashScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
