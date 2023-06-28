import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../constants.dart';

class alreadyhaveaccount extends StatelessWidget {
  final bool login;
  final Function? press;
  const alreadyhaveaccount({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don\'t have an account ? " : "Already have an account ? ",
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        GestureDetector(
          onTap: press as VoidCallback,
          child: Text(
            login ? "SIGN UP" : "SIGN IN",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
