import 'package:flutter/material.dart';
import 'package:healthcare/views/login/components/body.dart';

class login extends StatefulWidget {
  const login();

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
