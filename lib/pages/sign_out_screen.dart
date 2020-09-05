import 'package:flutter/material.dart';
import '../strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignOutScreen extends StatefulWidget {
  @override
  _SignOutScreenState createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        statusBarHeight -
        kBottomNavigationBarHeight;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple,
                  Colors.deepPurple[400],
                  Colors.deepPurple[300],
                  Colors.deepPurple[200],
                  Colors.deepPurple[100],
                ]),
          ),
        ),
        Positioned.fill(
          top: 200,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              Strings.signOutMessage,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned.fill(
          //top: 200,
          child: Align(
            alignment: Alignment.center,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/home');
              },
              color: Color.fromRGBO(49, 39, 79, 1),
              textColor: Colors.white,
              child: Text(
                Strings.yes,
                style: TextStyle(
                  fontSize: screenWidth * 0.037,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
