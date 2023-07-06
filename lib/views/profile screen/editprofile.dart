// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/constants.dart';
import '../login/components/body.dart';
import '/views/global.dart';
import 'charityInput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController username;
  late TextEditingController age;

  var obsecurepassword = true;
  var obsecurepassword2 = true;
  Color iconcolor = Colors.grey;
  Color iconcolor2 = Colors.grey;
  var password1;
  var password2;
  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data
    firstname = TextEditingController(text: Token.first_nameuser);
    lastname = TextEditingController(text: Token.last_nameuser);
    username = TextEditingController(text: Token.username);
    age = TextEditingController(text: Token.ageuser.toString());
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
            'edit profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/animatedbackground.gif'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CharityInputField(
                        'First Name',
                        onchanged: (String value) {
                          setState(() {
                            Token.first_nameuser = value;
                          });
                        },
                        validateStatus: (value) {
                          return value;
                        },
                        controller: firstname,
                        hintText: 'first name',
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: CharityInputField(
                        'Last Name',
                        onchanged: (String value) {
                          setState(() {
                            Token.last_nameuser = value;
                          });
                        },
                        validateStatus: (value) {
                          return value;
                        },
                        controller: lastname,
                        hintText: 'last name',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CharityInputField(
                      'Username',
                      onchanged: (String value) {
                        setState(() {
                          Token.username = value;
                        });
                      },
                      validateStatus: (value) {
                        return null;
                      },
                      controller: username,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CharityInputField(
                  'age',
                  onchanged: (String value) {
                    setState(() {
                      Token.ageuser = int.parse(value);
                    });
                  },
                  validateStatus: (value) {
                    return null;
                  },
                  controller: age,
                  keyboardtype: TextInputType.number,
                ),
                SizedBox(height: 26.h),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          kPlaceholder2,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            double.infinity,
                            60.h,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // updatePassword(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Update Password',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: ktextcolor2,
                                fontSize: 13),
                          ),
                          Icon(
                            Icons.lock,
                            color: ktextcolor2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          double.infinity,
                          56.h,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _submitForm();
                      //   saveprofile();
                    },
                    child: Text(
                      'Save Change',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ));
  }

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        Map<String, dynamic> body = {
          "first_name": Token.first_nameuser,
          "last_name": Token.last_nameuser,
          "username": Token.username,
          "age": "${Token.ageuser}",
        };
        String jsonBody = json.encode(body);
        final encoding = Encoding.getByName('utf-8');
       // print(Token.caregiverid);

        var url = Uri.parse(
            "${Token.server}caregiver/update/${Token.caregiverid.toString()}");
        var response = await http.put(url,
            headers: {
              'content-Type': 'application/json',
              "Authorization": " Token $token"
            },
            body: jsonBody,
            encoding: encoding);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode < 400) {
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    content: Text(
                      "Profile updated successfully",
                      style: TextStyle(color: Colors.green),
                    ),
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text(
                    "Profile NOT updated",
                    style: TextStyle(color: Colors.red),
                  ),
                ));
      }
    } catch (e) {
   //   print(e.toString());
    }
  }
}
