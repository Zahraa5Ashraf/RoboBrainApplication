// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import '/models/notifications.dart';
class notifcard extends StatefulWidget {
  const notifcard(
    this.notificationlabel, {
    super.key,
  });
  final Notificationcard notificationlabel;

  @override
  State<notifcard> createState() => _notifcardState();
}

class _notifcardState extends State<notifcard> {
  double textsize = 20;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(widget.notificationlabel.datetime);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '${widget.notificationlabel.sensorname}: ',
                            style: TextStyle(
                              fontSize: textsize,
                              color: Colors.grey[600],
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      ' Emergency detected the sensor value is ${widget.notificationlabel.value.toString()} ',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey))
                            ])),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${date.day}-${date.month}-${date.year}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${date.hour}:${date.minute}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          '${widget.notificationlabel.chairid}',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue[200]),
        ),
      ),
      // Icon(
      //   Icons.notification_add,
      //   size: 25,
      //   color: Colors.blue[200],
      // ),
    );
  }
}
