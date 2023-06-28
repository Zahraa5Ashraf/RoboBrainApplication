// ignore_for_file: dead_code

//import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

import 'package:dropdown_button2/dropdown_button2.dart';

import 'chair/chair.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

var token = "";

var formkey = GlobalKey<FormState>();
var email = "";
var password = "";
var fullname = "";
var username2 = "";
var id = "";
var phone = "";
var address = "";
var age2 = "";
var gender2 = "";
Future SignUp(BuildContext cont) async {
  /*REMOVE COMMENT WHEN ONLINE*/

  // Map<String, dynamic> body = {
  //   "id": id,
  //   "email": email,
  //   "password": password,
  //   "patient_full_name": fullname,
  //   "username": username2,
  //   "phone_number": phone,
  //   "address": address,
  //   "age": age2,
  //   "gender": gender2,
  // };
  // String jsonBody = json.encode(body);
  // final encoding = Encoding.getByName('utf-8');
  // if (email == "" ||
  //     password == "" ||
  //     id == "" ||
  //     fullname == "" ||
  //     username2 == "" ||
  //     phone == "" ||
  //     address == "" ||
  //     age2 == "") {
  //   print('Fields have not to be empty');
  // } else {
  //   var url =
  //       Uri.parse("https://cba7-196-221-98-202.eu.ngrok.io/patient/signup");
  //   var response = await http.post(url,
  //       headers: {'content-Type': 'application/json'},
  //       body: jsonBody,
  //       encoding: encoding);
  //   var result = response.body;
  //   print(result);

  /*REMOVE COMMENT WHEN ONLINE*/

  Navigator.push(
    cont,
    MaterialPageRoute(
      builder: (context) => addchair(),
    ),
  );

  // print('Registration successful');
  // print(result);

  // var data = json.decode(response.body);
  // if (data["message"] == "Success") {
  //   token = data["access_token"];
  //   print("Registeration succeeded");
  //   Navigator.pop(
  //     cont,
  //     MaterialPageRoute(
  //       builder: (context) => successful(),
  //     ),
  //   );
  // } else {
  //   print("Registeration Failed");
  // }
  //}
}

class _registerState extends State<register> {
  @override
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var idController = TextEditingController();
  var usernameController = TextEditingController();
  var fullnameController = TextEditingController();
  var addressController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  bool passwordVisible = true;
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
      // fetch_users();
    }

    //var gender =

    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            "assets/images/background-gradient.png"))),
              )),
          Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 20, right: 20, bottom: 40),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SIGN UP',
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: passwordVisible,
                          //  obsecure: passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                          ),
                          controller: passwordController,

                          onChanged: (String value) {
                            password = value;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Fullname',
                            prefixIcon: Icon(Icons.person),
                          ),
                          controller: fullnameController,
                          onChanged: (String value) {
                            fullname = value;
                          },
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_pin_rounded),
                          ),
                          controller: usernameController,
                          onChanged: (String value) {
                            username2 = value;
                          },
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'City',
                            prefixIcon: Icon(Icons.map),
                          ),
                          controller: addressController,
                          onChanged: (String value) {
                            address = value;
                          },
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Chair ID',
                            prefixIcon: Icon(Icons.wheelchair_pickup),
                          ),
                          controller: idController,
                          onChanged: (String value) {
                            id = value;
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          controller: phoneController,
                          onChanged: (String value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Age',
                            prefixIcon: Icon(Icons.lock_clock),
                          ),
                          controller: ageController,
                          onChanged: (String value) {
                            age2 = value;
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //  mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 10,
                              ),
                              child: Text(
                                '⚤ Gender:',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton2(
                                isExpanded: true,
                                value: gender2,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 17),
                                //underline:true ,
                                items: ['male', 'female'].map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    gender2 = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              'REGISTER',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                SignUp(context);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: Text('SIGN IN'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// void validateAndSave() {
//   final FormState form = _formKey.currentState;
//   if (form.validate()) {
//     print('Form is valid');
//   } else {
//     print('Form is invalid');
//   }
// }
