import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/constants.dart';

import 'circular_progress.dart';

class PercentageIndicatior extends StatefulWidget {
  final String percentage;
  const PercentageIndicatior({super.key, required this.percentage});

  @override
  State<PercentageIndicatior> createState() => _PercentageIndicatiorState();
}

class _PercentageIndicatiorState extends State<PercentageIndicatior> {
  @override
  Widget build(BuildContext context) {
    var percent = double.parse(widget.percentage);
    return SizedBox(
      width: 64.w,
      height: 64.w,
      child: Stack(
        children: [
          Positioned(
            top: -8.w,
            left: -8.w,
            child: SizedBox(
                width: 80.w,
                height: 80.w,
                child: CustomPaint(
                  foregroundPainter: CircleProgress(percent as double),
                  child: SizedBox(
                    width: 80.w,
                    height: 80.w,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPlaceholder2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ${widget.percentage} %',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
