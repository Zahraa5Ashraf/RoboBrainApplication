// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/views/services/notif_service.dart';
//import 'package:http/http.dart' as http;
import 'package:healthcare/network/dio_helper.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/services/routes.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) => MaterialApp(
        title: 'healthcare',
        theme: AppTheme(context).initTheme(),
        debugShowCheckedModeBanner: false,
        home: login(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
