import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.deepPurple,
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.purpleAccent,
            Colors.purple,
            Colors.purple[800],
            Colors.deepPurple
          ]
        ),
      ),     
    );
  }
}