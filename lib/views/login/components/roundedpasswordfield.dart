import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'textfieldcontainer.dart';

class roundedpasswordfield extends StatefulWidget {
  final ValueChanged<String> onchanged;
  final controller;
  final bool passwordVisible;
  final FormFieldValidator validateStatus;
  const roundedpasswordfield({
    super.key,
    required this.onchanged,
    required this.passwordVisible,
    this.controller,
    required this.validateStatus,
  });

  @override
  State<roundedpasswordfield> createState() => _roundedpasswordfieldState();
}

class _roundedpasswordfieldState extends State<roundedpasswordfield> {
  var passwordVisible = true;
  Color iconcolor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: passwordVisible,
      onChanged: widget.onchanged,
      validator: widget.validateStatus,
      decoration: InputDecoration(
        hintText: "password",
        icon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: iconcolor,
          ),
          onPressed: () {
            setState(() {
              if (iconcolor == Colors.grey) {
                iconcolor = kPrimaryColor;
              } else {
                iconcolor = Colors.grey;
              }
              passwordVisible = !passwordVisible;
            });
          },
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
