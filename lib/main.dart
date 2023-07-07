// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/views/Welcome.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/login/components/body.dart';

import 'package:healthcare/views/services/notif_service.dart';
import 'package:http/http.dart' as http;
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
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up :  ${message.messageId}');
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
  NotificationService().initNotification();
  runApp(const healthcare());
}

class healthcare extends StatefulWidget {
  const healthcare({super.key});

  @override
  State<healthcare> createState() => _healthcareState();
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
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    Token.deviceToken = (await messaging.getToken())!;
    print('Device Token: ${Token.deviceToken}');
  }

  // gettoken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   Tokenid = prefs.get('token');
  // }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    gettokenfcm();
  }

  var Tokenid;
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    Tokenid = prefs.get('token');
    if (Tokenid != null) {
      setState(() {
        token = Tokenid;
        print('token user:$token');
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
