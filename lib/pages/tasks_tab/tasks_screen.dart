import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../strings.dart';
import 'add_task.dart';
import 'task_list.dart';
import 'task.dart';
import '../database.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showAddTaskPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return AddTask();
      });
    }

    return StreamProvider<List<Task>>.value(
      value: DatabaseService().tasks,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          title: Text("My Tasks"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.add),
              label: Text(Strings.addTaskTab),
              onPressed: _showAddTaskPanel,
            ),
          ],
        ),
        body: TaskList(),
      ),
    );

  }
}