import 'package:flutter/material.dart';
import '../flags.dart';
import '../strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../alerts.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        statusBarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: screenHeight * 0.07),
            child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                onPressed: () {
                  _firebaseAuth.signOut();
                  Navigator.pushNamed(context, '/home');
                },
                child: Text(
                  Strings.signOut,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: screenHeight * 0.03),
                Text(
                  Strings.verifyEmailTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  Strings.verifyEmailMessage1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                Text(
                  Strings.verifyEmailMessage2,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.21),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                  ),
                ),
                SizedBox(height: screenHeight * 0.21),
                ButtonTheme(
                  minWidth: screenWidth * 0.73,
                  height: screenHeight * 0.09,
                  child: RaisedButton(
                    onPressed: resendEmail,
                    color: Colors.deepPurple,
                    child: Text(
                      Strings.resendEmail,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                ButtonTheme(
                  minWidth: screenWidth * 0.73,
                  height: screenHeight * 0.09,
                  child: RaisedButton(
                    onPressed: emailVerificationCheck,
                    color: Colors.white,
                    child: Text(
                      Strings.emailVerified,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> emailVerificationCheck() async {
    User user = _firebaseAuth.currentUser;
    await user.reload();
    user = _firebaseAuth.currentUser;
    if (user.emailVerified) {
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  Future<void> resendEmail() async {
    if (!Flag.verificationSent) {
     User user = _firebaseAuth.currentUser;
      await user.sendEmailVerification();
      Flag.verificationSent = true;
    } else {
      alertDialog(context, Strings.authenticationErrorTitle, Strings.resendEmailError);
    }
  }
}
