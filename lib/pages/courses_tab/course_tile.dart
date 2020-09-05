import 'package:flutter/material.dart';
import 'course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseTile extends StatelessWidget {
  final Course course;

  CourseTile({this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: Card(
        child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.chrome_reader_mode,
                  color: Colors.deepPurpleAccent),
            ),
            title: Text(course.name),
            trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.deepPurpleAccent),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("courses")
                      .doc(course.courseId)
                      .delete();
                }),
            onTap: () {}),
      ),
    );
  }
}
