import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarController controller;
  Map<DateTime, List<dynamic>> events;
  List<dynamic> selectedEvents;
  TextEditingController eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    controller = CalendarController();
    eventController = TextEditingController();
    events = {};
    selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text('My Schedule'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              events: events,
              onDaySelected: (date, events, holidays){
                setState(() {
                  selectedEvents = events;
                });
              },
              calendarController: controller,
            ),
            ...selectedEvents.map((event) => ListTile(
              title: Text(event),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addEvent(),
      ),
    );
  }

  addEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: eventController,
        ),
        actions: <Widget>[
          FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (eventController.text.isNotEmpty) {
                  setState(() {
                    if (events[controller.selectedDay] != null) {
                      events[controller.selectedDay].add(eventController.text);
                    } else {
                      events[controller.selectedDay] = [eventController.text];
                    }
                    prefs.setString("events", json.encode(encodeMap(events)));
                    eventController.clear();
                    Navigator.pop(context);
                  });
                }
              }),
        ],
      ),
    );
  }
}
