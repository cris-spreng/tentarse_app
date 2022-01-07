import 'dart:async';
import 'dart:convert';


import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tentarse_v02/home.dart';
import 'package:tentarse_v02/login.dart';
// fondo AMARILLO F6C744

class Splash extends StatefulWidget {
  const Splash({
    Key key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Location location = Location();
  bool isAuth = false;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var user = localStorage.getString('user');
    Map<String, dynamic> userMap = jsonDecode(user);
    if(token != null){
      setState(() {
        isAuth = true;
      });
      print("Token : $token");
      print("isAuth = $isAuth");
    }else{print("isAuth = $isAuth");}
    if(token != null){print(userMap['name']);}
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      print(permissionRequestedResult);
      if (permissionRequestedResult == PermissionStatus.denied) {
        //|| permissionRequestedResult==PermissionStatus.deniedForever){
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Tentarse'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Esta aplicación requiere el uso de tu ubicación para funcionar.'),
                    // Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _requestPermission();
                  },
                ),
              ],
            );
          },
        );
      } else if (permissionRequestedResult == PermissionStatus.deniedForever) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Tentarse'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Esta aplicación requiere el uso de tu ubicación para funcionar.'),
                    Text(
                        'Debes permitirlo desde tus ajustes o no podrás continuar.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }else{
        // IF LOCATION ESTA DISPONIBLE
        Timer(
            Duration(seconds: 1),
                () => setState(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  if(isAuth){
                    return Home();
                  }else{
                    return Login();
                  }
                })
              );
            }));
      }
    }
  } // Future<void> _requestPermission...

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        // width: double.infinity,
        // height: double.infinity,
        child: Container(
          color: Color(0xFFFFC600),
          // width: double.infinity,
          // height: double.infinity,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/plato.splash.02.png',
              height: 400, fit: BoxFit.fill),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 60),
            child: Image.asset('assets/images/logo.blanco.png',
                height: 150, fit: BoxFit.fill),
          ),
        ],
      )
    ]);
  }
}
