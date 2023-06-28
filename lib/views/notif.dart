import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/HomePage.dart';

import '../constants.dart';
import 'login/components/body.dart';

class notif extends StatefulWidget {
  static List<dynamic> activities = [];

  const notif({super.key});

  @override
  State<notif> createState() => _notifState();
}

class _notifState extends State<notif> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/animatedbackground.gif'),
            fit: BoxFit.cover),
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [kPrimary2, Colors.white]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          Age: globalage,
                          Username: globalusername,
                          Gender: globalgender,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 25,
                    //  left: 25,
                    // right: 25,
                  ),
                  color: Colors.white,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListViewItem(index);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 20,
                        );
                      },
                      itemCount: 10),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        Icons.notification_add,
        size: 25,
        color: Colors.blue[200],
      ),
    );
  }

  Widget ListViewItem(int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    message(index),
                    TimeandDate(index),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget message(int index) {
    double textsize = 20;
    return Container(
        child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: 'Alert: ',
                style: TextStyle(
                  fontSize: textsize,
                  color: Colors.grey[600],
                ),
                children: [
                  TextSpan(
                      text: ' Emergency detected in one of the sensors',
                      style: TextStyle(fontSize: 15, color: Colors.grey))
                ])));
  }

  Widget TimeandDate(int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '18-2-2023',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          Text(
            '8:10 pm',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
