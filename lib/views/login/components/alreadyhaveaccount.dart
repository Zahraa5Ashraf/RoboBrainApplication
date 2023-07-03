
// ignore_for_file: camel_case_types

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
          login ? "Don't have an account ? " : "Already have an account ? ",
          style: const TextStyle(
            color: kPrimaryColor,
          ),
        ),
        GestureDetector(
          onTap: press as VoidCallback,
          child: Text(
            login ? "SIGN UP" : "SIGN IN",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
