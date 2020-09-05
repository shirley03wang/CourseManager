import 'package:flutter/material.dart';
import '../strings.dart';
import 'courses_tab/courses_screen.dart';
import 'sign_out_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          CoursesScreen(),
          Center(child: Text(Strings.tasks)),
          Center(child: Text(Strings.schedule)),
          SignOutScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text(Strings.courses),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text(Strings.tasks),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text(Strings.schedule),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text(Strings.signOut),
          ),
        ],
        onTap: (index){
          setState((){
            _currentIndex = index;
          });
        }
      ),
    );
  }
}
