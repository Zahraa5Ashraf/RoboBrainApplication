// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/views/global.dart';
import 'package:healthcare/views/login/Login.dart';
import 'package:healthcare/views/login/components/roundedbutton.dart';

import '../../constants.dart';
import '../chair/chair.dart';
import 'details.dart';
import 'profile_card.dart';

class body extends StatelessWidget {
  const body({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    // style button important
    final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      backgroundColor: kPrimaryColor,
    );
    //style button important
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          const Positioned(
            top: 50,
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 20, color: ktextcolor2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const ProfileCard(),
                const Spacer(),
                Details(
                  title: 'Email address',
                  desc: Token.emailuser,
                ),
                const Spacer(),
                Details(
                  title: 'Username',
                  desc: Token.username,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Details(
                        title: 'Wheelchairs',
                        desc: 'Check Your personal chairs'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const addchair(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.w,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            4.r,
                          ),
                          color: kPlaceholder2,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: ktextcolor1,
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Center(
                  child: roundedbutton(
                      size: size,
                      flatbuttonstyle: flatbuttonstyle,
                      text: 'Logout',
                      textcolor: Colors.white,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const login(),
                          ),
                        );
                      }),
                ),
                const Spacer(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
