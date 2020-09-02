import 'package:flutter/material.dart';
import '../strings.dart';
import '../input_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coursemanager/alerts.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _email;
  final _formKey = GlobalKey<FormState>();
  final _inputValidator = InputValidator();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        statusBarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              top: screenHeight * 0.23,
              bottom: screenHeight * 0.2),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  Strings.passwordReset,
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      ),
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
                SizedBox(height: screenHeight * 0.5),
                Center(
                  child: ButtonTheme(
                    minWidth: screenWidth * 0.45,
                    height: screenHeight * 0.085,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: resetPassword,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text(
                        Strings.submit,
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
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: _email);
        alertDialog(
            context, Strings.passwordReset, Strings.resetPasswordMessage);
      } catch (error) {
        print(error.message);
        alertDialog(context, Strings.authenticationErrorTitle, error.message);
      }
    }
  }
}
