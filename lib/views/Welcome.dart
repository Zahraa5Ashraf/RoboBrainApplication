import 'package:flutter/material.dart';

import 'package:healthcare/views/login_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Background
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            "assets/images/background-gradient.png"))),
              )),
          //WELCOME
          Container(
            padding: EdgeInsets.all(100),
            alignment: Alignment.topCenter,
            child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/welcome.png"),
                        fit: BoxFit.contain))),
          ),

          //image
          Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 4,
              child: Container(
                  width: 512,
                  height: 560,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/doctor.png"),
                          fit: BoxFit.contain)))),
          //BUTTON
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 5,
            child: Container(
                margin: EdgeInsets.all(70),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.0),
                    )),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login_screen(),
                      ),
                    );
                  },
                  child: Ink(
                    width: 200,
                    decoration: BoxDecoration(

                        //   gradient: LinearGradient(
                        //       colors: [Colors.deepPurple, Colors.orange]),
                        ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text('START', textAlign: TextAlign.center),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
