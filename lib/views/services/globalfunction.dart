import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../global.dart';
import '../login/components/body.dart';
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
          "Authorization": "Bearer $token"
        },
        body: jsonBody,
        encoding: encoding,
      );
      print(response2.body);
      print(response2.statusCode);
      return response2;
    } catch (e) {
      //  print(e.toString()); // print error
    }
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

Future<void> removeTokenFromSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String tokenKey = 'token'; // Replace with your actual token key
  await sharedPreferences.remove(tokenKey);
}
