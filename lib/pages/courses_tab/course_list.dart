import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course.dart';
import 'course_tile.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<List<Course>>(context);

    if (courses != null) {
      courses.sort((a,b) => a.name.compareTo(b.name));
      return _courseWidget(courses);
    } else {
      return _loadingWidget();
    }
  }

  Widget _loadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _courseWidget(List<Course> courses) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return CourseTile(course: courses[index]);
      },
    );
  }
}