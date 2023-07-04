// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../HomePage.dart';
import '../global.dart';
import '../login/components/body.dart';
class GridDashboard extends StatefulWidget {
  const GridDashboard({super.key});

  @override
  State<GridDashboard> createState() => _GridDashboardState();
}

var heartint = 100.0;
var tempint = 100.0;
var heart2 = '100.0';
var temp2 = '100.0';
var oxrate = '59';
var oxrateint = 50;

class _GridDashboardState extends State<GridDashboard> {
  Items item1 = Items(
    title: "77",
    subtitle: "patient1",
  );

  Items item2 = Items(
    title: "33",
    subtitle: "patient2",
  );

  Items item3 = Items(
    title: "wheelchair3",
    subtitle: "patient3",
  );

  Items item4 = Items(
    title: "wheelchair4",
    subtitle: "patient4",
  );

  Items item5 = Items(
    title: "wheelchair5",
    subtitle: "patient5",
  );

  Items item6 = Items(
    title: "wheelchair6",
    subtitle: "patient6",
  );
  int selectedIndex = -1; // Index of the selected item

  @override
  Widget build(BuildContext context) {
    Color color = kPlaceholder2;
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return GridView.builder(
      itemCount: myList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16),
      itemBuilder: (context, index) {
        Items data = myList[index];
        return GestureDetector(
          onDoubleTap: () async {
            setState(() {
              Token.selectedchairid = data.title;
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
              reload();
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
                        'ID:${data.title}',
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
                        data.subtitle,
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
  }

  Future<void> reload() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    Age: globalage,
                    Username: globalusername,
                    Gender: globalgender,
                  )));
    } catch (e) {
      //print(e.toString());
    }
    return;
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
