// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/services/getfcm.dart';
import '../../main.dart';
import '../../models/notifications.dart';
import '../global.dart';
import 'dart:core';
import '../login/components/body.dart';
import 'notificationcard.dart';

class notificationtab extends StatefulWidget {
  const notificationtab({super.key});

  @override
  State<notificationtab> createState() => _notificationtabState();
}

final List<dynamic> notifications = [];

String sensor_name = '';
double sensor_value = 0.0;
int chairID = 0;
DateTime date = DateTime.now();

class _notificationtabState extends State<notificationtab> {
  @override
  void initState() {
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

  void showNotification() async {
    String? fcmKey = await getFcmToken();
    print('fcm: $fcmKey');
    setState(() {
      Token.counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing ${Token.counter}",
        "How you doin ?",
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/animatedbackground.gif'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 500,
                        padding: const EdgeInsets.only(
                          top: 25,
                        ),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                return notifcard(notifications[index]);
                              },
                            ),
                            const Divider(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 70,
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                //    showNotification();
                                getData();
                              },
                              child: const Text(
                                'Click her',
                                style: TextStyle(color: ktextcolor2),
                              )),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future getData() async {
    try {
      /**FOR TEST */
      var url2 = Uri.parse('${Token.server}caregiver/notification');
      var response2 = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": " Bearer $token"
        },
      );
      // Parse the JSON response
      final jsonData = json.decode(response2.body);
     // print(jsonData);

      // Clear the notifications list before starting the loop
      notifications.clear();

      // Iterate over the parsed data and append to the notifications list
      for (var data in jsonData) {
        Notificationcard notification = Notificationcard(
          chairid: data['chair_id'],
          datetime: data['date'],
          sensorname: data['sensor'],
          value: data['value'],
        );

        notifications.add(notification);
      }
    } catch (e) {
   //   print(e.toString()); // print error
    }

    return notifications;
  }
}
