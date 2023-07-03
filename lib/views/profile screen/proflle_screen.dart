// import 'package:kickfunding/theme/app_animation.dart';
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'body.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: body(size: size),
    );
  }
}
