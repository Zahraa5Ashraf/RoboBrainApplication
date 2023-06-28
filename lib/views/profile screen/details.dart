import 'package:flutter/material.dart';
import 'package:healthcare/constants.dart';

class Details extends StatelessWidget {
  const Details({
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: kPrimaryColor,
                fontSize: 20,
              ),
        ),
        Text(
          desc,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ktextcolor2,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
