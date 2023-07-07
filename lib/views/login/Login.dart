// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:healthcare/views/login/components/body.dart';

class login extends StatefulWidget {
   login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Body(),
    );
  }
}
