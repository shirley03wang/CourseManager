import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../strings.dart';
import '../input_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coursemanager/alerts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  final _inputValidator = InputValidator();
  //final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        statusBarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 350,
                    width: screenWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/login_background.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    height: 350,
                    width: screenWidth + 20,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/login_background2.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    top: 340,
                    left: 35,
                    child: Text(
                      Strings.login,
                      style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 5, bottom: 0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                  size: screenWidth * 0.085,
                                ),
                                hintText: Strings.email,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: _inputValidator.emailValidator,
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: screenWidth * 0.085,
                                ),
                                hintText: Strings.password,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: _inputValidator.passwordValidator,
                              onSaved: (input) => _password = input,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Center(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'reset_password');
                      },
                      child: Text(
                        Strings.forgotPassword,
                        style:
                            TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: ButtonTheme(
                      minWidth: screenWidth * 0.45,
                      height: screenHeight * 0.085,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: login,
                        color: Color.fromRGBO(49, 39, 79, 1),
                        textColor: Colors.white,
                        child: Text(
                          Strings.login,
                          style: TextStyle(
                            fontSize: screenWidth * 0.037,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email, password: _password);
        User user = result.user;

        if (user.emailVerified) {
          Navigator.pushNamed(context, '/dashboard');
        } else {
          // sending email verification
          try {
            Navigator.pushNamed(context, 'email_verify');
          } catch (e) {
            print(e.message);
          }
        }
      } catch (error) {
        // Note that exception won't be caught in VSCode but works fine in
        // Android Studio
        print(error.message);
        alertDialog(context, Strings.authenticationErrorTitle, error.message);
      } 
    }
  }
}
