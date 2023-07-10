// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:healthcare/views/login/components/roundedbutton.dart';
import 'package:healthcare/views/login/components/roundedinputfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import '../global.dart';
import '../login/components/body.dart';
import 'addwheelchair.dart';
import 'gridview.dart';

class addchair extends StatefulWidget {
  const addchair({super.key});

  @override
  State<addchair> createState() => _addchairState();
}

bool trackpatient = true;
bool addwheelchair = false;
final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(
    vertical: 20,
    horizontal: 40,
  ),
  backgroundColor: kPrimaryColor,
);
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: kPlaceholder3,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: kPrimaryColor)),
  //     onPressed: () {},
  padding: const EdgeInsets.all(10.0),

  //     color: Color.fromRGBO(0,160,227,1),
  //     textColor: Colors.white,
);
final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
  foregroundColor: kPrimaryLightColor,
  backgroundColor: kPrimaryColor,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(color: kPrimaryColor)),
  //     onPressed: () {},

  padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
  //     color: Color.fromRGBO(0,160,227,1),
  //     textColor: Colors.white,
);

class _addchairState extends State<addchair> {
  @override
  void initState() {
    super.initState();
  }

  int counter = 0;
  String idchair = '';
  String ppass = '';
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
          'Wheelchairs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/animatedbackground.gif'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background-gradient.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const SizedBox(height: 480, child: GridDashboard()),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 157.5,
                            child: ElevatedButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                if (Token.selectedwheelchair != -1) {
                                  editWheelchair();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'you have to select wheelchair!')));
                                }
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 157.5,
                            child: ElevatedButton(
                              style: raisedButtonStyle2,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Addwheelchair()),
                                );
                              },
                              child: const Text(
                                "New +",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: kPlaceholder3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // SizedBox(
                      //   height: 50,
                      //   width: 335,
                      //   child: ElevatedButton(
                      //     style: raisedButtonStyle2,
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const Addwheelchair()),
                      //       );
                      //     },
                      //     child: const Text(
                      //       "Add wheelchair",
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  editWheelchair() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      builder: (_) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 200,
            top: 32.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedInputField(
                action: TextInputAction.go,
                onchanged: ((value) {
                  setState(() {
                    idchair = value;
                  });
                }),
                controller: null,
                hinttext: 'Chair ID',
                icon: Icons.wheelchair_pickup,
                validateStatus: (value) {
                  return null;
                },
                type: TextInputType.number,
              ),
              RoundedInputField(
                action: TextInputAction.go,
                onchanged: ((value) {
                  setState(() {
                    ppass = value;
                  });
                }),
                controller: null,
                hinttext: 'Password',
                icon: Icons.lock,
                validateStatus: (value) {
                  return null;
                },
                type: TextInputType.text,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 15,
                ),
                width: 315,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: TextButton(
                    style: flatbuttonstyle,
                    onPressed: () {
                      _save2();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: kPlaceholder3,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void delete() async {
    try {
      Map<String, dynamic> body = {
        "chair_id": idchair,
        "password": ppass,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url =
          Uri.parse("${Token.server}patient/info/${Token.selectedchairid}");

      var response = await http.delete(url,
          headers: {
            'content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: jsonBody,
          encoding: encoding);

      print(response.body);
      print(response.statusCode);
      if (response.statusCode > 300) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to delete')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wheelchair deleted successfully')));
        setState(() {
          Navigator.pop(context);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _save2() async {
    try {
      Map<String, dynamic> body = {
        "chair_id": idchair,
        "password": ppass,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url = Uri.parse(
          "${Token.server}patient/chair-update/${Token.selectedchairid}");

      var response = await http.put(url,
          headers: {
            'content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: jsonBody,
          encoding: encoding);

      print(response.body);
      print(response.statusCode);
      if (response.statusCode > 300) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text(
                    "failed to delete",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text(
                    "wheelchair is deleted successfully",
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
