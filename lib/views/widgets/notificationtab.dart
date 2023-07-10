// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:healthcare/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import '../../models/notifications.dart';
import '../global.dart';
import 'dart:core';
import '../login/components/body.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'notificationcard.dart';

class notificationtab extends StatefulWidget {
  const notificationtab({super.key});

  @override
  State<notificationtab> createState() => _notificationtabState();
}

final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
    GlobalKey<LiquidPullToRefreshState>();

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
      //backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background-gradient.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: getData,
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        child: Column(children: [
                          const SizedBox(
                            height: 40,
                          ),

                          SizedBox(
                            height: 600,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                if (notifications.isEmpty) {
                                  return const Text(
                                    'EMPTY',
                                    style: TextStyle(
                                        fontSize: 25, color: ktextcolor1),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      notifcard(
                                        notifications[index],
                                      ),
                                      const Divider(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          // Center(
                          //   child: SizedBox(
                          //     height: 70,
                          //     width: 200,
                          //     child: ElevatedButton(
                          //         onPressed: () {
                          //           //  getLocation();
                          //           //    showNotification();
                          //           //   getData();
                          //         },
                          //         child: const Text(
                          //           'Click her',
                          //           style: TextStyle(color: ktextcolor2),
                          //         )),
                          //   ),
                          // ),
                        ]),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List> getData() async {
    try {
      var url2 = Uri.parse('${Token.server}caregiver/notification');
      var response2 = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": " Bearer $token"
        },
      );

      final jsonData = json.decode(response2.body);
      //  print(jsonData);

      notifications.clear();

      for (var data in jsonData) {
        Notificationcard notification = Notificationcard(
          notificationid: data['id'],
          chairid: data['chair_id'],
          datetime: data['date'],
          sensorname: data['sensor'],
          value: data['value'],
        );
        setState(() {
          notifications.add(notification);
        });
      }
    } catch (e) {
      // Handle error appropriately
      //  print(e.toString());
    }

    return notifications;
  }
}
