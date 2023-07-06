// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import '../login/components/body.dart';
import 'addwheelchair.dart';
import 'gridview.dart';

class addchair extends StatefulWidget {
  const addchair({super.key});

  @override
  State<addchair> createState() => _addchairState();
}

final List<dynamic> patients = [];
bool trackpatient = true;
bool addwheelchair = false;

Future getData() async {
  try {
/**FOR TEST */
    var url2 = Uri.parse("${Token.server}caregiver/assigned-patients");
    var response2 = await http.get(
      url2,
      headers: {
        'content-Type': 'application/json',
        "Authorization": " Token $token"
      },
    );
    print(response2.body);

    if (response2.statusCode == 200) {
      // Parse the JSON response
      // final jsonData = json.decode(response2.body);

      // Clear the specificurgents list before starting the loop
      patients.clear();

      // Iterate over the parsed data and append to the urgents list
      // for (var data in jsonData) {
      // Urgent urgent = Urgent(
      //   id: data['id'],
      //   userimage: data['user_image'],

      //   title: data['title'],
      //   target: target2,
      //   percent: percent
      //       .toStringAsFixed(0), // Convert to string with 2 decimal places
      //   assetName: data['image'],
      //   category: data['category'],
      //   organizer: data['created_by'],
      //   remaining: remaining.toString(),
      //   rate: double.parse(data['rate']['avg_rate'].toString()),
      //   details: data['details'],
      //   end_date: data['end_date'],
      //   start_date: data['start_date'],
      //   days: days,
      //   tags: data['tags'],
      // );

      //  myprojects.add(urgent);
      //  }
    }
  } catch (e) {
    //print(e.toString()); // print error
  }
  // return myprojects;
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

class _addchairState extends State<addchair> {
  @override
  Widget build(BuildContext context) {
    getData();
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
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const SizedBox(height: 380, child: GridDashboard()),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Addwheelchair()),
                              );
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
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: 335,
                    child: ElevatedButton(
                      style: raisedButtonStyle2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Addwheelchair()),
                        );
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
}
