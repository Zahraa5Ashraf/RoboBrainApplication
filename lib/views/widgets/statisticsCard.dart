// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import '../../constants.dart';

class stasticsCard extends StatelessWidget {
  const stasticsCard({
    super.key,
    required this.title,
        required this.value,

  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kPlaceholder3,
                  kPlaceholder3,
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 24,
                    color: ktextcolor2,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  color: ktextcolor2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
