import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/login_screen.dart';

import '../HomePage.dart';
import '../home.dart';
import '../login/components/body.dart';

class blood extends StatelessWidget {
  const blood({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/animatedbackground.gif'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
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
                  "Sugar Blood Level",
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
            Center(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  'here data of sensor will be added',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
