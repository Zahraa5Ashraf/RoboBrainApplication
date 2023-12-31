// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, empty_catches, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/Welcome.dart';
import 'package:healthcare/views/login/components/roundedinputfield.dart';
import 'package:healthcare/views/profile%20screen/proflle_screen.dart';

import 'package:healthcare/views/signup/signup_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../global.dart';
import 'alreadyhaveaccount.dart';
import 'roundedbutton.dart';
import 'roundedpasswordfield.dart';

class Body extends StatefulWidget {
  Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

/* For HoME Page */
bool check = false;
var globalusername = 'Zahraa';
var globalage = '23';
var globalgender = 'Female';
var Username = 'Zahraa';
var Age = '23';
var Gender = 'Female';
var Heart;
/* For HoME Page */

/* Variables*/
var token = "";
var email = "";
var password = "";
/* Variables*/

class _BodyState extends State<Body> {
  var formkey2 = GlobalKey<FormState>();

  /* Controllers */
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  /* Controllers */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // style button important
    final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      backgroundColor: kPrimaryColor,
    );
    //style button important
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: size.height,
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
            Form(
              key: formkey2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Image.asset(
                    "assets/icons/login_top.png",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    action: TextInputAction.next,
                    onchanged: (String value) {
                      email = value;
                    },
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    hinttext: "your email",
                    icon: Icons.person,
                  ),
                  roundedpasswordfield(
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                    onchanged: (value) {
                      password = value;
                    },
                    controller: passwordController,
                    passwordVisible: true,
                  ),
                  roundedbutton(
                    flatbuttonstyle: flatbuttonstyle,
                    text: "LOGIN",
                    press: () {
                      if (formkey2.currentState!.validate()) {
                        _login();
                        // reload();
                      }
                    },
                    size: size,
                    textcolor: Colors.white,
                  ),
                  alreadyhaveaccount(
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const signup(),
                          ));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
      // globalusername = Username;
      // globalage = Age;
      // globalgender = Gender;

      /* UNCOMMENT WHEN SERVER ONLINE */
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      if (email == "zozo" || password == "zozo") {
        reload();
        //print('Fields have not to be empty');
      } else {
        var url = Uri.parse("${Token.server}caregiver/login");

        var response = await http.post(url,
            headers: {
              'content-Type': 'application/json',
            },
            body: jsonBody,
            encoding: encoding);

        var data = json.decode(response.body);
        if (data["message"] == "Success") {
          token = data["access_token"];
        }
        /* UNCOMMENT WHEN SERVER ONLINE */
      }

      var url2 = Uri.parse("${Token.server}caregiver/info");
      var response = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      var data2 = json.decode(response.body);
      // print(data2);
      storeToken();
      setState(() {
        Token.caregiverid = data2["id".toString()];
        Token.username = data2["username".toString()];
        Token.first_nameuser = data2["first_name".toString()];
        Token.last_nameuser = data2["last_name".toString()];
        Token.emailuser = data2["email".toString()];
        Token.ageuser = data2["age".toString()];
      });
      print(data2);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
      /* UNCOMMENT WHEN SERVER ONLINE */
    } catch (e) {
      //  print(e.toString());
    }
  }

  storeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> reload() async {
    check = true;
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SplashScreen()));
    return;
  }
}
