import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/login/components/alreadyhaveaccount.dart';
import 'package:healthcare/views/login/components/body.dart';
import 'package:healthcare/views/login/components/roundedbutton.dart';
import 'package:healthcare/views/login/components/roundedinputfield.dart';
import 'package:healthcare/views/login/components/roundedpasswordfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:healthcare/views/profile%20screen/proflle_screen.dart';

import '../chair/chair.dart';
import 'body.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

/* Variables*/
var token = "";
var formkey1 = GlobalKey<FormState>();
var email = "";
var password = "";
var first_name = "";
var username = "";
var id = "";
var phone = "";
var last_name = "";
var age = "";
var gender = "male";
/* Variables */
Future SignUp(BuildContext cont) async {
  /**removecomment when online */
  Map<String, dynamic> body = {
    "id": id,
    "email": email,
    "password": password,
    "first_name": first_name,
    "last_name": last_name,
    "username": username,
    // "phone_number": phone,
    "age": age,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  if (email == "" ||
      password == "" ||
      first_name == "" ||
      username == "" ||
      phone == "" ||
      last_name == "" ||
      age == "") {
    print('Fields have not to be empty');
  } else {
    var url =
        Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/caregiver/signup");
    var response = await http.post(url,
        headers: {'content-Type': 'application/json'},
        body: jsonBody,
        encoding: encoding);
    var result = response.body;
    print(result);

    print('Registration successful');
    print(result);

    var data = json.decode(response.body);
    if (data["message"] == "Success") {
      token = data["access_token"];
      print("Registeration succeeded");
      Navigator.push(
        cont,
        MaterialPageRoute(
          builder: (context) => profile(),
        ),
      );
    } else {
      print("Registeration Failed");
    }
  }
  /**removecomment when online */
}

class _signupState extends State<signup> {
  @override
  /* Controllers */
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var idController = TextEditingController();
  var usernameController = TextEditingController();
  var first_nameController = TextEditingController();
  var last_nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  bool passwordVisible = true;
  /* Controllers */
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
    }

    Size size = MediaQuery.of(context).size;

    bool value = false;

    // style button important
    final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      backgroundColor: kPrimaryColor,
    );
    //style button important
    return Scaffold(
      body: body(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 100, bottom: 100),
            child: Form(
              key: formkey1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Image.asset(
                    "assets/icons/signup_image.png",
                    height: size.height * 0.35,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedInputField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    hinttext: "Email",
                    icon: Icons.email,
                    onchanged: ((String value) {
                      email = value;
                    }),
                    validateStatus: (value) {
                      if (value == '') {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  roundedpasswordfield(
                    onchanged: (value) {
                      password = value;
                    },
                    validateStatus: (value) {
                      if (value == "") {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                    controller: passwordController,
                    passwordVisible: true,
                  ),
                  RoundedInputField(
                    controller: first_nameController,
                    type: TextInputType.name,
                    hinttext: "First name",
                    icon: Icons.face_sharp,
                    onchanged: ((String value) {
                      first_name = value;
                    }),
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  RoundedInputField(
                    controller: usernameController,
                    type: TextInputType.name,
                    hinttext: "Username",
                    icon: Icons.account_circle,
                    onchanged: ((String value) {
                      username = value;
                    }),
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  RoundedInputField(
                    controller: last_nameController,
                    type: TextInputType.text,
                    hinttext: "Last name",
                    icon: Icons.location_history_rounded,
                    onchanged: ((String value) {
                      last_name = value;
                    }),
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  RoundedInputField(
                    controller: ageController,
                    type: TextInputType.number,
                    hinttext: "Age",
                    icon: Icons.person,
                    onchanged: ((String value) {
                      age = value;
                    }),
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  RoundedInputField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    hinttext: "Phone number",
                    icon: Icons.phone,
                    onchanged: ((String value) {
                      phone = value;
                    }),
                    validateStatus: (value) {
                      if (value!.isEmpty) {
                        return 'Field must not be empty';
                      }
                      return null;
                    },
                  ),
                  roundedbutton(
                    size: size,
                    flatbuttonstyle: flatbuttonstyle,
                    text: "SIGNUP",
                    textcolor: Colors.white,
                    press: () {
                      if (formkey1.currentState!.validate()) {
                        // print('successful');
                        SignUp(context);
                      }
                    },
                  ),
                  alreadyhaveaccount(
                      login: false,
                      press: () {
                        
                        Navigator.pop(
                          context,
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
