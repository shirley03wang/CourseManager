import 'package:coursemanager/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../strings.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        statusBarHeight -
        kBottomNavigationBarHeight;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
    ));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  Strings.appName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              Strings.welcome,
              style: TextStyle(
                fontSize: 45,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 80),
            ButtonTheme(
                minWidth: screenWidth * 0.73,
                height: screenHeight * 0.09,
                child: Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    color: Colors.deepPurple,
                    child: Text(
                      Strings.signUp,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ButtonTheme(
                minWidth: screenWidth * 0.73,
                height: screenHeight * 0.09,
                child: Center(
                  child: RaisedButton(
                    onPressed: () {
                     //Navigator.pushNamed(context, '/login');
                     Navigator.push(context, new MaterialPageRoute(builder: (context) =>new LoginScreen()));
                    },
                    color: Colors.white,
                    child: Text(
                      Strings.login,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
