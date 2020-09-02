import 'package:flutter/material.dart';
import '../strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height - statusBarHeight - kBottomNavigationBarHeight;

    return Scaffold(
      body: Container(),
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
            icon: Icon(Icons.account_box),
            title: Text(Strings.account),
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
