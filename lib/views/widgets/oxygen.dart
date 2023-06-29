//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/HomePage.dart';

import 'package:healthcare/views/global.dart';
import '../login/components/body.dart';

class oxygen extends StatefulWidget {
  static List<dynamic> activities = [];

  // const oxygen({super.key});

  @override
  State<oxygen> createState() => _oxygenState();
}

var date = '11 FEBRUARY';
// Future update(BuildContext cont) async {
//   Map<String, dynamic> body = {
//     "email": "",
//     "password": "",
//   };
//   String jsonBody = json.encode(body);
//   final encoding = Encoding.getByName('utf-8');

//   var url = Uri.parse("https://304d-197-133-196-239.eu.ngrok.io/chair/data");
//   var response = await http.get(
//     url,
//     headers: {
//       'content-Type': 'application/json',
//       "Authorization": "Bearer ${token}"
//     },
//   );

//   var data = json.decode(response.body);
//   print(data);
//   test = data["oxygen_rate"].toString();
//   if (data["oxygen_rate"] < 120) {
//     print('patient died');
//   }
//   print(data["oxygen_rate"]);
// }

class _oxygenState extends State<oxygen> {
  @override
  Widget build(BuildContext context) {
    // update(context);

    // DioHelper.getData(url: 'activity/', query: {'': ''}).then((value) {
    //   print(value!.data['type'].toString());
    //   test = value.data['type'].toString();
    // }).catchError((error) {
    //   print(error.toString());
    // });
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'Oxygen Rate',
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
              // top: 30.0,
              ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 25,
                    //  left: 25,
                    // right: 25,
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: Stack(children: [
                          Container(
                            width: 300.0,
                            height: 300.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 142, 205, 235),
                                width: 7.0,
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  const Text(
                                    '11 February',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 114, 109, 109)),
                                  ),
                                  Builder(builder: (context) {
                                    return Text(
                                      Token.oxygenreading,
                                      style: const TextStyle(
                                          fontSize: 60,
                                          color:
                                              Color.fromARGB(255, 73, 71, 71)),
                                    );
                                  }),
                                  const Text(
                                    '❤️  BPM',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 114, 109, 109)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 130,
                        width: 600,
                        margin: const EdgeInsets.all(30.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.all(10)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.all(10)),
                                Row(
                                  children: [
                                    Text(
                                      "💙 ",
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                    Text(
                                      "51",
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ],
                                ),
                                Text(
                                  "MIN:4 DEC",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.all(10)),
                                Row(
                                  children: [
                                    Text(
                                      "💔 ",
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                    Text(
                                      "100",
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ],
                                ),
                                Text(
                                  "MAX:7 FEB",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Stream<DateTime> getTime() async* {
  DateTime currentTime = DateTime.now();
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield currentTime;
  }
}
