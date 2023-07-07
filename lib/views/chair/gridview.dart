// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/models/patients.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../HomePage.dart';
import '../global.dart';
import '../login/components/body.dart';

class GridDashboard extends StatefulWidget {
  const GridDashboard({
    super.key,
  });

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

final List<dynamic> patients = [];

var heartint = 100.0;
var tempint = 100.0;
var heart2 = '100.0';
var temp2 = '100.0';
var oxrate = '59';
var oxrateint = 50;

class _GridDashboardState extends State<GridDashboard> {
  int selectedIndex = -1; // Index of the selected item

  @override
  Widget build(BuildContext context) {
    Color color = kPlaceholder2;
    return FutureBuilder(
        future: fetchPatients(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return GridView.builder(
              itemCount: patients.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
              ),
              padding: const EdgeInsets.only(left: 16, right: 16),
              itemBuilder: (context, index) {
                Patient data = patients[index];
                return GestureDetector(
                  onDoubleTap: () async {
                    setState(() {
                      reload();
                      selectedIndex = index;

                      Token.selectedchairid = data.chair_parcode_id;
                    });

                    try {
                      var url = Uri.parse(
                          "${Token.server}patient/info/${Token.selectedchairid}");
                      var response = await http.get(
                        url,
                        headers: {
                          'content-Type': 'application/json',
                          "Authorization": "Bearer $token"
                        },
                      );
                      /*remove this comments*/
                      var data = json.decode(response.body);

                      globalusername = data["first_name"].toString();
                      globalage = data["age"].toString();
                      globalgender = data["gender"].toString();
                      //   print(data);
                    } catch (e) {
                      //   print(e.toString());
                    }
                  },
                  onTap: () {
                    setState(() {
                      selectedIndex = index;

                      Token.selectedwheelchair = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedIndex == index ? kPrimaryColor : color,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = -1;
                                    Token.selectedwheelchair = -1;
                                  });
                                },
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: color,
                                ))),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 14,
                              ),
                              Text(
                                'ID:${data.chair_parcode_id}',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: selectedIndex == index
                                        ? kPlaceholder2
                                        : ktextcolor1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                data.patient_name,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: selectedIndex == index
                                        ? kPlaceholder2
                                        : ktextcolor2,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<void> reload() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Reloading...'),
              ],
            ),
          ),
        );
      },
    );

    try {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context); // Close the progress dialog

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            Age: globalage,
            Username: globalusername,
            Gender: globalgender,
          ),
        ),
      );
    } catch (e) {
      // Handle error
    }
  }

  Future<List> fetchPatients() async {
    try {
      var url2 = Uri.parse("${Token.server}caregiver/assigned-patients");
      var response = await http.get(
        url2,
        headers: {
          'content-Type': 'application/json',
          "Authorization": " Token $token"
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final assignedPatients = jsonData['assigned_patients'];

        // Filter patients assigned to caregiver ID 4
        final patientsForCaregiver = assignedPatients
            .where((patient) => patient['caregiver_id'] == Token.caregiverid)
            .toList();
        patients.clear();
// Iterate over the parsed data and append to the Patients list
        for (var data in patientsForCaregiver) {
          Patient patient = Patient(
            chair_parcode_id: data['chair_parcode_id'],
            patient_id: data['patient_id'],
            patient_name: data['patient_name'],
          );
          setState(() {
            patients.add(patient);
          });
        }

        // Print or process the extracted patients
      } else {}
    } catch (e) {}
    return patients;
  }
}

class Items {
  String title;
  String subtitle;

  Items({
    required this.title,
    required this.subtitle,
  });
}
