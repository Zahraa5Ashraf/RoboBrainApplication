
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'textfieldcontainer.dart';

class RoundedInputField extends StatelessWidget {
  final String hinttext;
  final IconData icon;
  final TextInputType type;
  final controller;
  final ValueChanged<String> onchanged;
  final FormFieldValidator validateStatus;
  final TextInputAction action;

  const RoundedInputField({
    super.key,
    required this.hinttext,
    required this.action,
    required this.icon,
    required this.onchanged,
    required this.type,
    required this.controller,
    required this.validateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        textInputAction: action,
        keyboardType: type,
        controller: controller,
        onChanged: onchanged,
        validator: validateStatus,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hinttext,
            border: InputBorder.none),
      ),
    );
  }
}
