import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global.dart';
import 'getfcm.dart';

void showNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();

  Token.fcmKey = (await getFcmToken())!;
  print('fcm: ${Token.fcmKey}');
  // sendNotification(Token.deviceToken, 'test2 notification', 'test2 test2 test2');
  // setState(() {
  //   Token.counter++;
  // });
  // flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Testing ${Token.counter}",
  //     "How you doin ?",
  //     NotificationDetails(
  //         android: AndroidNotificationDetails(channel.id, channel.name,
  //             channelDescription: channel.description,
  //             importance: Importance.high,
  //             color: Colors.blue,
  //             playSound: true,
  //             icon: '@mipmap/ic_launcher')));
}

Future<void> sendNotification(
    String deviceToken, String title, String body) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=${Token.servertoken}',
  };

  final message = {
    'to': deviceToken,
    'notification': {
      'title': title,
      'body': body,
    },
  };

  final response = await http.post(
    url,
    headers: headers,
    body: json.encode(message),
  );

  if (response.statusCode == 200) {
   // print('Notification sent successfully');
  } else {
   // print('Failed to send notification');
  }
}

