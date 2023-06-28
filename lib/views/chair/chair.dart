import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:healthcare/views/login/components/roundedbutton.dart';
import 'package:healthcare/views/login/components/roundedinputfield.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ChairPage.dart';

class addchair extends StatefulWidget {
  static List<dynamic> activities = [];

  const addchair({super.key});

  @override
  State<addchair> createState() => _addchairState();
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: kPrimaryColor)),
  //     onPressed: () {},
  padding: EdgeInsets.all(10.0),
  primary: Colors.white,
  onPrimary: kPrimaryColor,

  //     color: Color.fromRGBO(0,160,227,1),
  //     textColor: Colors.white,
);
final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: kPrimaryColor)),
  //     onPressed: () {},

  padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
  primary: kPrimaryColor,
  onPrimary: kPrimaryLightColor,
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
    CardItem(
        urlImage: ('assets/images/wheelchair1.jpg'),
        title: 'ID:23940',
        subtitle: 'Name:Patient1'),
    CardItem(
        urlImage: ('assets/images/wheelchair3.jpg'),
        title: 'ID:37289',
        subtitle: 'Name:Patient2'),
    CardItem(
        urlImage: ('assets/images/wheelchair2.png'),
        title: 'ID:62890',
        subtitle: 'Name:Patient3'),
    CardItem(
        urlImage: ('assets/images/wheelchair1.jpg'),
        title: 'ID:23940',
        subtitle: 'Name:Patient1'),
    CardItem(
        urlImage: ('assets/images/wheelchair3.jpg'),
        title: 'ID:37289',
        subtitle: 'Name:Patient2'),
    CardItem(
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
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      backgroundColor: kPrimaryColor,
    );
    //style button important
    return Container(
      padding: EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/animatedbackground.gif'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Wheel-chair",
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
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    //  left: 25,
                    // right: 25,
                  ),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 400,
                            padding: EdgeInsets.only(
                                left: 35, right: 35, bottom: 20),
                            child: Center(
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                // physics: PageScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, int index) =>
                                    /**ICONS EDIT AND DELETE */
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: IconButton(
                                    //         onPressed: () {
                                    //           showDialog(
                                    //             context: context,
                                    //             builder: (context) => SimpleDialog(
                                    //               children: [
                                    //                 RoundedInputField(
                                    //                   onchanged: ((value) {
                                    //                     setState(() {
                                    //                       idchair = value;
                                    //                     });
                                    //                   }),
                                    //                   controller: null,
                                    //                   hinttext: 'add chair id',
                                    //                   icon: Icons.wheelchair_pickup,
                                    //                   validateStatus: (value) {},
                                    //                   type: TextInputType.text,
                                    //                 ),
                                    //                 roundedbutton(
                                    //                     size: size,
                                    //                     flatbuttonstyle: flatbuttonstyle,
                                    //                     text: 'Update',
                                    //                     textcolor: Colors.white,
                                    //                     press: () {
                                    //                       setState(() {
                                    //                         data[index] = idchair;
                                    //                       });
                                    //                     })
                                    //               ],
                                    //             ),
                                    //           );
                                    //         },
                                    //         icon: Icon(
                                    //           Icons.edit,
                                    //           color: _color,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: IconButton(
                                    //         onPressed: () {
                                    //           setState(() {
                                    //             data.removeAt(index);
                                    //           });
                                    //         },
                                    //         icon: Icon(
                                    //           Icons.delete,
                                    //           color: _color2,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    /**ICONS EDIT AND DELETE */
                                    Center(
                                  child: buildcard(
                                    item: items[index],
                                    delete: IconButton(
                                      splashColor: kPrimaryLightColor,
                                      onPressed: () {
                                        setState(() {
                                          items.removeAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_rounded,
                                        size: 35,
                                        color: _color2,
                                      ),
                                    ),
                                    edit: IconButton(
                                      splashColor: kPrimary2,
                                      onPressed: () {
                                        ShowDialogChair(
                                            context, size, flatbuttonstyle);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 25,
                                        color: _color,
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, _) => SizedBox(
                                  width: 10,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                right: 10,
                                left: 10,
                                bottom: 5,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 325,
                                    height: 70,
                                    child: ElevatedButton(
                                      style: raisedButtonStyle,
                                      onPressed: () {
                                        ShowDialogChair(
                                            context, size, flatbuttonstyle);
                                      },
                                      child: Text("Add Wheelchair +",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ),

                                  // Container(
                                  //   height: 70,
                                  //   width: 325,
                                  //   margin: EdgeInsets.only(bottom: 50),
                                  //   child: ElevatedButton(
                                  //     style: raisedButtonStyle2,
                                  //     onPressed: () {
                                  //       Navigator.of(context)
                                  //         ..pop()
                                  //         ..pop();
                                  //     },
                                  //     child: Text("Submit",
                                  //         style: TextStyle(fontSize: 20)),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
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
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Fill in patient\'s data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                RoundedInputField(
                  onchanged: ((value) {
                    setState(() {
                      idchair = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'chair id',
                  icon: Icons.wheelchair_pickup,
                  validateStatus: (value) {},
                  type: TextInputType.text,
                ),
                RoundedInputField(
                  onchanged: ((value) {
                    setState(() {
                      ppass = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'Password',
                  icon: Icons.lock,
                  validateStatus: (value) {},
                  type: TextInputType.text,
                ),
                RoundedInputField(
                  onchanged: ((value) {
                    setState(() {
                      pfirstname = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'First name',
                  icon: Icons.person,
                  validateStatus: (value) {},
                  type: TextInputType.text,
                ),
                RoundedInputField(
                  onchanged: ((value) {
                    setState(() {
                      plastname = value;
                    });
                  }),
                  controller: null,
                  hinttext: 'Last name',
                  icon: Icons.person,
                  validateStatus: (value) {},
                  type: TextInputType.text,
                ),
                RoundedInputField(
                  onchanged: ((value) {
                    setState(() {
                      page = value;
                    });
                  }),
                  controller: null,
                  hinttext: ' Age ',
                  icon: Icons.app_registration_sharp,
                  validateStatus: (value) {},
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.white, width: 1),
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
                SizedBox(
                  height: 10,
                ),
                roundedbutton(
                    size: size,
                    flatbuttonstyle: flatbuttonstyle,
                    text: 'Save',
                    textcolor: Colors.white,
                    press: () {
                      _save();
                      print(
                        '${pfirstname},+${plastname},+${pgender}+&${page}+,${idchair}+,${ppass}',
                      );
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
    print(data);
    if (data["message"] == "Success") {
      print("addchair succeeded");
    }
    /* UNCOMMENT WHEN SERVER ONLINE */
  }

  void _getchairs() {
    /* UNCOMMENT WHEN SERVER ONLINE */
    // var url2 = Uri.parse("https://cba7-196-221-98-202.eu.ngrok.io/patient/me");
    // var response = await http.get(
    //   url2,
    //   headers: {
    //     'content-Type': 'application/json',
    //     "Authorization": "Bearer ${token}"
    //   },
    // );

    // if (response.statusCode == 200) {
    //   var data2 = json.decode(response.body);
    //   print(data2);
    //
    // }
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: kPrimaryColor),
                ),
                Text(
                  item.subtitle,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
}
