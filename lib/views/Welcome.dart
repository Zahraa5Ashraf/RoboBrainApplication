import 'package:flutter/material.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/profile%20screen/proflle_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'global.dart';
import 'login/components/body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var Tokenid;
  void getinfo() async {
    try {
      var url2 = Uri.parse("${Token.server}caregiver/info");
      var response2 = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      var data2 = json.decode(response2.body);
      print(response2.statusCode);
      setState(() {
        Token.caregiverid = data2["id".toString()];
        Token.username = data2["username".toString()];
        Token.first_nameuser = data2["first_name".toString()];
        Token.last_nameuser = data2["last_name".toString()];
        Token.emailuser = data2["email".toString()];
        Token.ageuser = data2["age".toString()];
        Token.password = data2["password".toString()];
        print(data2);
      });
    } catch (e) {
      // print(e.toString());
    }
  }

  gettoken() async {
    final prefs = await SharedPreferences.getInstance();
    Tokenid = prefs.get('token');
  }

  @override
  void initState() {
    super.initState();

    gettoken();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (Tokenid == null) {
          // Check if the widget is still mounted before navigating
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => login(),
            ),
          );
        } else {
          // Check if the widget is still mounted before updating the state
          setState(() {
            token = Tokenid;
          });
          getinfo();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const profile(),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Dispose any resources here if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              SizedBox(
                //    width: 0.7.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      alignment: Alignment.center,
                      height: 500,
                      width: 700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
