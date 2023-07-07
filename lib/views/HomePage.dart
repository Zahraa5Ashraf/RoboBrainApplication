//import 'dart:convert';

// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/views/login/components/body.dart';

import 'package:healthcare/views/map.dart';

//import 'package:http/http.dart' as http;

import 'home.dart';
import 'profile screen/proflle_screen.dart';

class HomePage extends StatefulWidget {
  // const HomePage({super.key});
  final String Username;
  final String Age;
  final String Gender;

  const HomePage({
    super.key,
    required this.Username,
    required this.Age,
    required this.Gender,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color iconColor = Colors.white;

  //////////////////////////new code
  int pageIndex = 0;
  int currentIndex = 0;
  /////////////////new code
  List<Widget> screens = [
    home(
      age: globalage,
      gender: globalgender,
      username: globalusername,
    ),
    const map(),
    const profile(),
  ];

  void navigateToTab(int index) async {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //update(context);
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/animatedbackground.gif',
          ),
          fit: BoxFit.cover,
          //fit: BoxFit.cover
        ),
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [kPrimaryLightColor, Colors.white]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: currentIndex,
            elevation: 10,
            backgroundColor: Colors.white,
            onTap: navigateToTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.house_alt_fill,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.location_solid,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Icon(
                          CupertinoIcons.person_fill,
                        ),
                      ]),
                  label: ''),
            ]),
        body: screens[currentIndex],
      ),
    );
  }
}
