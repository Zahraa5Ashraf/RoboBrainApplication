// ignore_for_file: must_be_immutable

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
      title: "wheelchair1",
      subtitle: "patient1",
      event: "gender",
      img: "assets/images/wheelchair1.jpg");

  Items item2 = Items(
    title: "wheelchair2",
    subtitle: "patient2",
    event: "gender",
    img: "assets/images/wheelchair3.jpg",
  );
  Items item3 = Items(
    title: "wheelchair3",
    subtitle: "patient3",
    event: "gender",
    img: "assets/images/wheelchair2.png",
  );
  Items item4 = Items(
    title: "wheelchair4",
    subtitle: "patient4",
    event: "gender",
    img: "assets/images/wheelchair1.jpg",
  );
  Items item5 = Items(
    title: "wheelchair5",
    subtitle: "patient5",
    event: "gender",
    img: "assets/images/wheelchair2.png",
  );
  Items item6 = Items(
    title: "wheelchair6",
    subtitle: "patient6",
    event: "gender",
    img: "assets/images/wheelchair3.jpg",
  );

  GridDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = kPlaceholder2;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 42,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: ktextcolor1,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: ktextcolor2,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.event,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: ktextcolor2,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ),
                  
                ],

              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
