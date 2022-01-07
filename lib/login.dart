import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/api.dart';
import 'home.dart';
import 'social.dart';

//import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var email;
  var password;
/*
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
//   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 520,
            decoration: BoxDecoration(
                color: Color(0xFFFFC600),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0))),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/logo.blanco.png',
                      height: 150, fit: BoxFit.fill),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      obscureText: false,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingresa tu email';
                        }
                        email = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Correo electrónico",
                        hintStyle: TextStyle(),
                        contentPadding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor llena todos los campos';
                        }
                        password = value;
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        hintStyle: TextStyle(),
                        contentPadding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Text("¿Olvidaste tu contraseña?",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,) ,),
                    onTap: ()=>print("click!!!!!!"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        textStyle: TextStyle(color: Colors.black),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _login();
                        }},
                      child: _isLoading?Text("     Cargando...   "):Text("       Ingresar       "),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Social(),
        ],
      ),
    );
  }
  void _login() async{

    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password' : password
    };
    //_showMsg("cargando");
    var res = await Network().authData(data, 'login');
    var body = json.decode(res.body);
    print(body);

    if(res.statusCode==200){

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['access_token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Home()
        ),
      );
    }else{
      //_showMsg(body['message']);
    } // */

    setState(() {
      _isLoading = false;
    });
  }
}
