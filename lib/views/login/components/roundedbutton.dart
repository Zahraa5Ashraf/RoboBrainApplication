import 'package:flutter/material.dart';

class roundedbutton extends StatelessWidget {
  final String text;
  final Function press;
  final Color textcolor;
  const roundedbutton({
    Key? key,
    required this.size,
    required this.flatbuttonstyle,
    required this.text,
    required this.textcolor,
    required this.press,
  }) : super(key: key);

  final Size size;
  final ButtonStyle flatbuttonstyle;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        bottom: 15,
      ),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: flatbuttonstyle,
          onPressed: press as VoidCallback,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
