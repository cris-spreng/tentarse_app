import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tentarse_v02/menu/menu_up_item.dart';
import 'package:tentarse_v02/menu/menu_up_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';
import '../login.dart';

// import 'package:flutter/services.dart';

class MenuUp extends StatelessWidget {
  final context;

  MenuUp(this.context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
        child: Drawer(
          semanticLabel: "Menu Principal",
          child: ListView(
            children: [
              MenuUpHeader(), // Widget constructor del header
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Plato",
              ),
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Restaurant",
              ),
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Platos más cercanos",
              ),
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Platos con más likes",
              ),
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Platos mejor evaluados",
              ),
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Tipo de comida",
              ),
              MenuUpItem(
                icon:Icon(Icons.group),
                text: "Precio",
              ),
              InkWell(
                onTap: logout,
                child: MenuUpItem(
                  icon:Icon(Icons.group),
                  text: "Logout",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void logout() async{
    var res = await Network().getData('logout');
    var body = json.decode(res.body);
    print(res.body);
    if(res.statusCode==200){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Login()
        ),
      );
    }else{
      print("Error");
    }
  }
}


