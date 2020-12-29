import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../strings.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _taskName;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            Strings.addTaskTitle,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    //spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  )
                ]),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              validator: (value) =>
              value.isEmpty ? "Please add a task" : null,
              onChanged: (value) => setState(() => _taskName = value),
            ),
          ),
          SizedBox(height: 30),
          ButtonTheme(
            minWidth: 120,
            height: 40,
            child: RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  FirebaseFirestore.instance.collection("tasks").add({'name': _taskName});
                }
              },
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: Text(
                Strings.submit,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}