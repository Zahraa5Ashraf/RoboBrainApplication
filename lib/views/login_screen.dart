import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:healthcare/views/register.dart';
import 'package:healthcare/views/global.dart';


class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

// bool check = false;
// var formkey = GlobalKey<FormState>();
// var globalusername = 'ksksk';
// var globalage = '22';
// var globalgender = 'sklds';
// var Username = '';
// var Age = '';
// var Gender = '';
// var Heart;
// bool _isLoading = false;
// final emailController = TextEditingController();
// final passwordController = TextEditingController();
// String uname = "robobrain@gmail.com";
// String pass = "123456";
// var email = "";
// var password = "";
Future Login(BuildContext cont) async {
  Map<String, dynamic> body = {
    "email": email,
    "password": password,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  if (email == "" || password == "") {
    print('Fields have not to be empty');
  } else {
    var url = Uri.parse("https://6425-102-190-68-2.eu.ngrok.io/patient/login");
    var response = await http.post(url,
        headers: {
          'content-Type': 'application/json',
        },
        body: jsonBody,
        encoding: encoding);

    var data = json.decode(response.body);
    print(data);
    if (data["message"] == "Success") {
      token = data["access_token"];
      print(token);
      print("Login succeeded");
      // update(cont);
      // Navigator.push(
      //     cont,
      //     MaterialPageRoute(
      //         builder: (context) => HomePage(
      //               Age: globalage,
      //               Username: globalusername,
      //               Gender: globalgender,
      //             )));
    } else {
      // print("User not Found");
      // emailController.text = "";
      // passwordController.text = "";
    }
  }
}

Future update(BuildContext cont2) async {
  // var url = Uri.parse("https://6425-102-190-68-2.eu.ngrok.io/patient/me");
  // var response = await http.get(
  //   url,
  //   headers: {
  //     'content-Type': 'application/json',
  //     "Authorization": "Bearer ${token}"
  //   },
  // );
  //var data2 = json.decode(response.body);
  //print(data2);
  // Username = data2["username"].toString();
  // Gender = data2["gender"].toString();
  // Age = data2["age"].toString();

  // Username = "Zahraa";
  // Gender = "female";
  // Age = '23';

  //Heart = '900.0';
}

class _login_screenState extends State<login_screen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    //update(context);
    // sensorupdate(context);
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
          Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        //   controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String value) {
                          email = value;
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'Email cannot be blank' : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          //  suffixIcon: Icon(Icons.visibility),
                        ),
                        //  controller: passwordController,
                        onChanged: (value) {
                          password = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) =>
                            value!.isEmpty ? 'Password cannot be blank' : null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child:
                              // _isLoading
                              //     ? CircularProgressIndicator()
                              //     :
                              Text(
                            'SIGN IN',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            _login();
                            //      reload();
                          },
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ), //Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => register(),
                                  ),
                                );
                              },
                              child: Text('REGISTER')),
                          TextButton(
                              onPressed: () {
                                //   _getCurrentUser();

                                setState(() {
                                  // globalusername = Username;
                                  // globalage = Age;
                                  // globalgender = gender;
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => HomePage(
                                //       // Age: globalage,
                                //       // Username: globalusername,
                                //       // Gender: globalgender,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Text('Or Click here')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    if (email == 'zozo' && password == 'zozo') {
    } else {
      Map<String, dynamic> body = {
        "email": email,
        "password": password,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      if (email == "" || password == "") {
        print('Fields have not to be empty');
      } else {
        var url =
            Uri.parse("https://cba7-196-221-98-202.eu.ngrok.io/patient/login");
        var response = await http.post(url,
            headers: {
              'content-Type': 'application/json',
            },
            body: jsonBody,
            encoding: encoding);

        var data = json.decode(response.body);
        print(data);
        if (data["message"] == "Success") {
          token = data["access_token"];
          print(token);
          print("Login succeeded");
        }
      }

      var url2 =
          Uri.parse("https://cba7-196-221-98-202.eu.ngrok.io/patient/me");

      var response = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
      );
      // if (response.statusCode == 200) {
      //   var data2 = json.decode(response.body);
      //   print(data2);
      //   Username = data2["username"].toString();
      //   Gender = data2["gender"].toString();
      //   Age = data2["age"].toString();
      //   globalusername = Username;
      //   globalage = Age;
      //   globalgender = Gender;
      //   print('Username=$Username');
      //   print('global username=$globalusername');
      // }

      // void _getCurrentUser() async {
      //   Username = 'Mohamed';
      //   Age = '22';
      //   Gender = 'male';
      //   // var url2 = Uri.parse("https://cba7-196-221-98-202.eu.ngrok.io/patient/me");

      //   // var response = await http.get(
      //   //   url2,
      //   //   headers: {
      //   //     'content-Type': 'application/json',
      //   //     "Authorization": "Bearer ${token}"
      //   //   },
      //   // );
      //   // if (response.statusCode == 200) {
      //   //   var data2 = json.decode(response.body);
      //   //   print(data2);
      //   //   Username = data2["username"].toString();
      //   //   Gender = data2["gender"].toString();
      //   //   Age = data2["age"].toString();

      //     globalusername = Username;
      //     globalage = Age;
      //     globalgender = Gender;
      //     print('username=$globalusername');
      //     print('Age=$globalage');
      //     print('Age=$Gender');
      //   }
      // }
    }

    // Future<void> reload() async {
    //   check = true;
    //   print(check);
    //   await Future.delayed(Duration(seconds: 3));
    //   print('after 3 secs $check');
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => HomePage(
    //                 Age: globalage,
    //                 Username: globalusername,
    //                 Gender: globalgender,
    //               )));
    //   return;
    // }
    //   }
  }
}
