import 'package:flutter/material.dart';
import 'task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  TaskTile({this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CheckboxListTile(
        title: Text(widget.task.name),
        secondary: IconButton(
            icon: Icon(Icons.delete, color: Colors.deepPurpleAccent),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("tasks")
                  .doc(widget.task.taskId)
                  .delete();
            }),
        controlAffinity: ListTileControlAffinity.leading,
        value: checked,
        onChanged: (bool value) {
          setState(() {
            checked = value;
          });
        },
      ),
    );
  }
}

