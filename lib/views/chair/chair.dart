// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/login/components/roundedbutton.dart';
import 'package:healthcare/views/login/components/roundedinputfield.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'ChairPage.dart';
import 'gridview.dart';

class addchair extends StatefulWidget {
  static List<dynamic> activities = [];

  const addchair({super.key});

  @override
  State<addchair> createState() => _addchairState();
}

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

Color _color = kPrimaryColor;
Color _color2 = kPrimaryColor;

class CardItem {
  final String urlImage;
  final String title;
  final String subtitle;
  const CardItem({
    required this.urlImage,
    required this.subtitle,
    required this.title,
  });
}

class _addchairState extends State<addchair> {
  List<CardItem> items = [
    const CardItem(
        urlImage: ('assets/images/wheelchair1.jpg'),
        title: 'ID:23940',
        subtitle: 'Name:Patient1'),
    const CardItem(
        urlImage: ('assets/images/wheelchair3.jpg'),
        title: 'ID:37289',
        subtitle: 'Name:Patient2'),
    const CardItem(
        urlImage: ('assets/images/wheelchair2.png'),
        title: 'ID:62890',
        subtitle: 'Name:Patient3'),
    const CardItem(
        urlImage: ('assets/images/wheelchair1.jpg'),
        title: 'ID:23940',
        subtitle: 'Name:Patient1'),
    const CardItem(
        urlImage: ('assets/images/wheelchair3.jpg'),
        title: 'ID:37289',
        subtitle: 'Name:Patient2'),
    const CardItem(
        urlImage: ('assets/images/wheelchair2.png'),
        title: 'ID:62890',
        subtitle: 'Name:Patient3'),
  ];
  String idchair = '';
  String pfirstname = '';
  String plastname = '';
  String ppass = '';
  String page = '';
  String pgender = '';
  String dropdownValue = 'Male';
  @override
  Widget build(BuildContext context) {
    // style button important
    Size size = MediaQuery.of(context).size;
    final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      backgroundColor: kPrimaryColor,
    );
    //style button important
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(height: 490, child: GridDashboard()),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 157.5,
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            if (Token.selectedwheelchair != -1) {
                              ShowDialogChair(context, size, flatbuttonstyle);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
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
                          style: raisedButtonStyle,
                          onPressed: () {},
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 20,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: 335,
                    child: ElevatedButton(
                      style: raisedButtonStyle2,
                      onPressed: () {
                        ShowDialogChair(context, size, flatbuttonstyle);
                      },
                      child: const Text(
                        "Add wheelchair",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowDialogChair(
      BuildContext context, Size size, ButtonStyle flatbuttonstyle) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Center(
                    child: Text(
                  'Fill in patient\'s data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                RoundedInputField(
                  action: TextInputAction.go,
                  onchanged: ((value) {
                    setState(() {
                      idchair = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'chair id',
                  icon: Icons.wheelchair_pickup,
                  validateStatus: (value) {
                    return null;
                  },
                  type: TextInputType.text,
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
                RoundedInputField(
                  action: TextInputAction.go,
                  onchanged: ((value) {
                    setState(() {
                      pfirstname = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'First name',
                  icon: Icons.person,
                  validateStatus: (value) {
                    return null;
                  },
                  type: TextInputType.text,
                ),
                RoundedInputField(
                  action: TextInputAction.go,
                  onchanged: ((value) {
                    setState(() {
                      plastname = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'Last name',
                  icon: Icons.person,
                  validateStatus: (value) {
                    return null;
                  },
                  type: TextInputType.text,
                ),
                RoundedInputField(
                  action: TextInputAction.go,
                  onchanged: ((value) {
                    setState(() {
                      page = value;
                    });
                  }),
                  controller: null,
                  hinttext: ' Age ',
                  icon: Icons.app_registration_sharp,
                  validateStatus: (value) {
                    return null;
                  },
                  type: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                      //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                      //<-- SEE HERE
                    ),
                    filled: true,
                    fillColor: kPrimaryLightColor,
                  ),
                  dropdownColor: kPrimaryLightColor,
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      pgender = newValue;
                    });
                  },
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                roundedbutton(
                    size: size,
                    flatbuttonstyle: flatbuttonstyle,
                    text: 'Save',
                    textcolor: Colors.white,
                    press: () {
                      _save();
                      setState(() {
                        //  items[index].title = idchair;
                      });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _save() async {
    /* UNCOMMENT WHEN SERVER ONLINE */
    Map<String, dynamic> body = {
      "chair_id": idchair,
      "password": ppass,
      "first_name": pfirstname,
      "last_name": plastname,
      "age": page,
      "gender": pgender,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var url =
        Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/patient/info");

    var response = await http.post(url,
        headers: {
          'content-Type': 'application/json',
        },
        body: jsonBody,
        encoding: encoding);

    var data = json.decode(response.body);
    if (data["message"] == "Success") {}
    /* UNCOMMENT WHEN SERVER ONLINE */
  }

  Widget buildcard({
    required CardItem item,
    required IconButton delete,
    required IconButton edit,
  }) =>
      Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    delete,
                    edit,
                  ],
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            item.urlImage,
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            splashColor: kPrimary2,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChairPage(item: item)));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: kPrimaryColor),
                ),
                Text(
                  item.subtitle,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
}


    // Container(
                      //   height: 400,
                      //   padding: const EdgeInsets.only(
                      //       left: 35, right: 35, bottom: 20),
                      // child: Center(
                      //   child: ListView.separated(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.horizontal,
                      //     // physics: PageScrollPhysics(),
                      //     itemCount: items.length,
                      //     itemBuilder: (context, int index) => Center(
                      //       child: buildcard(
                      //         item: items[index],
                      //         delete: IconButton(
                      //           splashColor: kPrimaryLightColor,
                      //           onPressed: () {
                      //             setState(() {
                      //               items.removeAt(index);
                      //             });
                      //           },
                      //           icon: Icon(
                      //             Icons.remove_rounded,
                      //             size: 35,
                      //             color: _color2,
                      //           ),
                      //         ),
                      //         edit: IconButton(
                      //           splashColor: kPrimary2,
                      //           onPressed: () {
                      //             ShowDialogChair(
                      //                 context, size, flatbuttonstyle);
                      //           },
                      //           icon: Icon(
                      //             Icons.edit,
                      //             size: 25,
                      //             color: _color,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     separatorBuilder: (context, _) => const SizedBox(
                      //       width: 10,
                      //     ),
                      //   ),
                      // ),
                      //   ),