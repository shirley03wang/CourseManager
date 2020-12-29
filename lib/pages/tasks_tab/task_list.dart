import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);

    if (tasks != null) {
      tasks.sort((a,b) => a.name.compareTo(b.name));
      return _taskWidget(tasks);
    } else {
      return _loadingWidget();
    }
  }

  Widget _loadingWidget() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _taskWidget(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(task: tasks[index]);
      },
    );
  }
}