import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'splash.dart';
import 'login.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) =>  Login(),
        '/home': (BuildContext context) => Home(),
    },
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Color(0xFFFFC600),
//        accentColor: Color(0xFF363445),
        accentColor: Color(0xFFFFC600),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Color(0xFF3B3B39)),
        ),
      ),
      title: 'Tentarse v0.2',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    )); // runApp
  });
}