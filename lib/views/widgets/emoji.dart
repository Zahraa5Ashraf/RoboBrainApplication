import 'package:flutter/material.dart';

class emoji extends StatelessWidget {
  final String emojiface;

  const emoji({
    Key? key,
    required this.emojiface,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey[600], borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(18.0),
      child: Text(
        emojiface,
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}
