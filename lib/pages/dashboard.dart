import 'package:flutter/material.dart';
import '../strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height - statusBarHeight - kBottomNavigationBarHeight;

    return Scaffold(
      body: Column(
        children: <Widget>[
          // Image.asset(
          //     'assets/dashboard.png',
          //     height: screenHeight*0.7,
          // ),
          // SizedBox(height: screenHeight*0.05),
          Center(
            child: Text(
              Strings.hangTight,
              style: TextStyle(
                fontSize: screenWidth*0.06,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: screenHeight*0.03),
          Center(
            child: Text(
              Strings.noEventsMessage,
              style: TextStyle(
                fontSize: screenWidth*0.035,
                color: Colors.grey,
              ),
            ),
          ),
          Center(
            child: Text(
              Strings.tryAgain,
              style: TextStyle(
                fontSize: screenWidth*0.035,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: screenHeight*0.08),
          Center(
            child: FlatButton(
              onPressed: () {
                _firebaseAuth.signOut();
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                Strings.signOut,
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
