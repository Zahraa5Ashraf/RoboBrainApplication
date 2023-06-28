import 'package:flutter/material.dart';

import '../../constants.dart';

class body extends StatelessWidget {
  final Widget child;

  const body({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/images/signup_top.png"),
            width: size.width * 0.4,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/images/main_bottom.png"),
            width: size.width * 0.3,
          ),
          child,
        ],
      ),
    );
  }
}
