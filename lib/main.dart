import 'package:coursemanager/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'pages/welcome_screen.dart';
import 'pages/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/dashboard.dart';
import 'pages/reset_password_screen.dart';
import 'pages/email_verification_screen.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => WelcomeScreen(),
    '/sign_up': (context) => SignUpScreen(),
    '/dashboard': (context) => Dashboard(),
    //'/login': (context) => LoginScreen(),
    'reset_password': (context) => ResetPasswordScreen(),
    'email_verify': (context) => EmailVerificationScreen(),
  },
  debugShowCheckedModeBanner: false,
));
}