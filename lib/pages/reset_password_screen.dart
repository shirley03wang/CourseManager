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
      appBar: AppBar(
        title: Text(Strings.forgotPassword),
        backgroundColor: Colors.green[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
              top: screenHeight * 0.07),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Strings.email,
                  style: TextStyle(
                    fontSize: screenWidth * 0.037,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                          color: Colors.black,
                        ),
                      ),
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
                SizedBox(height: screenHeight * 0.6),
                Center(
                  child: ButtonTheme(
                    minWidth: screenWidth * 0.78,
                    height: screenHeight * 0.085,
                    child: RaisedButton(
                      onPressed: resetPassword,
                      color: Colors.green[400],
                      child: Text(
                        Strings.submit,
                        style: TextStyle(
                          color: Colors.white,
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
        alertDialog(context, Strings.forgotPassword, Strings.resetPasswordMessage);
      } catch (error) {
        print(error.message);
        alertDialog(context, Strings.authenticationErrorTitle, error.message);
      }
    }
  }
}
