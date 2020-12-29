import 'package:cloud_firestore/cloud_firestore.dart';
import 'courses_tab/course.dart';
import 'tasks_tab/task.dart';

class DatabaseService {

  final CollectionReference courseCollection =
  FirebaseFirestore.instance.collection('courses');

  final CollectionReference taskCollection =
  FirebaseFirestore.instance.collection('tasks');

  // course list from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Course(
        name: doc.data()['name'],
        courseId: doc.id,
      );
    }).toList();
  }

  Stream<List<Course>> get courses {
    return courseCollection.snapshots().map(_courseListFromSnapshot);
  }

  // task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
        name: doc.data()['name'],
        taskId: doc.id,
      );
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

}