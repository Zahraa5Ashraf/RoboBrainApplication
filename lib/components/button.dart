import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class buttonWidget extends StatelessWidget {
  const buttonWidget({
    super.key,
    required this.label,
    required this.press,
  });
  final String label;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          kPrimary2,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30.r,
            ),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            double.infinity,
            56.h,
          ),
        ),
      ),
      onPressed: press as VoidCallback,
      child: Text('${label}'),
    );
  }
}
