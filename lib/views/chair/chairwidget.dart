import 'package:flutter/material.dart';

class chairwidget extends StatelessWidget {
  const chairwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.amber,
            // child: Image.asset(
            //   pic,
            //   height: 70.0,
            //   width: 70,
            // ),
          ),
        ),
        title: Text(
          'Chair 1',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'Patient name',
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
