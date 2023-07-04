// ignore_for_file: prefer_final_fields, prefer_const_constructors, library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:healthcare/constants.dart';
import '/views/global.dart';

class CountryInputField extends StatefulWidget {
  const CountryInputField(
      {super.key, required this.onChanged,
      required this.onSaved,
      this.validateStatus,
      required this.height,
      required this.color});

  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validateStatus;
  final ValueChanged<String> onSaved;
  final int height;
  final Color color;
  @override
  _CountryInputFieldState createState() => _CountryInputFieldState();
}

class _CountryInputFieldState extends State<CountryInputField> {
  List<String> _countries = [
    'Egypt',
    'Saudi Arabia',
    'Syria',
    'Iraq',
    'Yemen',
    // Add more countries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //  padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                widget.onChanged(value);
              },
              onSaved: (value) {
                widget.onSaved(value!);
              },
              style: TextStyle(
                color: ktextcolor2,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                hintText: 'choose your country',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ktextcolor2,
                      fontSize: 10,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: widget.height.h,
                ),
              ),
              readOnly: true,
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    setState(() {
                      Token.country = country.name;
                    });

        //            print('Select country: ${country.displayName}');
                  },
                );
              },
              controller: TextEditingController(text: Token.country),
            ),
          ),
        ],
      ),
    );
  }

  void _openCountryPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Country'),
          content: DropdownButton<String>(
            value: Token.country,
            onChanged: (String? value) {
              setState(() {
                Token.country = value!;
              });
              Navigator.of(context).pop();
            },
            items: _countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: ktextcolor2),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
