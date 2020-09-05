import 'package:cloud_firestore/cloud_firestore.dart';
import 'course.dart';

class DatabaseService {

  final CollectionReference courseCollection =
  FirebaseFirestore.instance.collection('courses');

  // events list from snapshot
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

}