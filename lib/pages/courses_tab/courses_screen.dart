import 'package:flutter/material.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'course_list.dart';
import 'course.dart';
import '../../strings.dart';
import '../add_course_from.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showAddCoursePanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return AddCourseForm();
      });
    }

    return StreamProvider<List<Course>>.value(
      value: DatabaseService().courses,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          title: Text("My Courses"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.add),
              label: Text(Strings.addCourseTab),
              onPressed: _showAddCoursePanel,
            ),
          ],
        ),
        body: CourseList(),
      ),
    );

  }
}