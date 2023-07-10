import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
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

Future<void> subscribeToDeviceTopic(
    String fcmToken, String topicName, String serverKey) async {
  final url =
      'https://iid.googleapis.com/iid/v1/$fcmToken/rel/topics/$topicName';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
  );

  if (response.statusCode == 200) {
    print('Device subscribed to topic: $topicName');
  } else {
    print('Failed to subscribe device to topic. Error: ${response.statusCode}');
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
        sendNotification('${Token.devicetokeennn}', 'Chair ID $chairParcodeId',
            'Heart Rate Emergency, value =$sensorheartdouble');
        postnotification('HeartRate', sensorheartdouble, chairParcodeId);
      }
      if (sensortempdouble > 37.0 || sensortempdouble < 35.0) {
        sendNotification('${Token.devicetokeennn}', 'Chair ID $chairParcodeId',
            'Tempratue Emergency, value =$sensortempdouble');
        postnotification('TempRate', sensortempdouble, chairParcodeId);
      }
      if (sensoroxratedouble < 94) {
        sendNotification('${Token.devicetokeennn}', 'Chair ID $chairParcodeId',
            'Oxygen Emergency, value =$sensoroxratedouble');
        postnotification('OxygRate', sensoroxratedouble, chairParcodeId);
      }
    }
  } catch (e) {
    // print(e.toString());
  }
}

void getcurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location services are disabled.');
    return;
  }

  // Request location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied.');
      return;
    }
  }

  // Get the current position
  Token.position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

Future<void> removeTokenFromSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String tokenKey = 'token'; // Replace with your actual token key
  await sharedPreferences.remove(tokenKey);
}
