import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileName extends StatefulWidget {



  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {

   String _name = "Nombre";
   String _mail = "email@mail.com";

  void _getName() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Map<String, dynamic> user = jsonDecode(localStorage.getString('user'));
    if(user != null){
      setState(() {
        _name = user['name'];
        _mail = user['email'];
      });
    }else{

    }
  }
// */
  @override
  void initState() {
    super.initState();
    _getName();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('assets/images/bla.png')),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 8, 2),
                child: Text(_name, // nombre usuario
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 2, 8, 0),
                child: Text(
                  _mail, // mail usuario
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
