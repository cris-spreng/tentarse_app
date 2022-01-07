import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'network/api.dart';
import 'menu/menu_up.dart';
import 'model/plato.dart';
import 'plato_items.dart';
import 'upload/upload.dart';
import 'profile_name.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  var _menuVisible = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Home0(),
    Text(
      'Index 2: Buscar',
      style: optionStyle,
    ),
    Text(
      '',
      style: optionStyle,
    ),
    Text(
      'Index 4: Bla',
      style: optionStyle,
    ),
    Text(
      'Index 5: Menu',
      style: optionStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();

    //_loadContent();
  }

  void _onItemTapped(int index) {
    print("Index: $index");
    switch (index) {
      case 2:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Upload()),
          );
        }
        break;
      case 4:
        {
          setState(() {
            _menuVisible = true;
          });
        }
        break;
      default:
        {
          setState(() {
            _selectedIndex = index;
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xFFFAFCFA),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actionsIconTheme: IconThemeData(
                // size: 30.0,
                color: Color(0xFFFFC600),
                opacity: 10.0),
            title: Image.asset('assets/images/logo.blanco.png',
                height: 50, fit: BoxFit.fill),
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
              Builder(
                builder: (BuildContext ctxDrawer) {
                  return Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(ctxDrawer).openEndDrawer();
                      },
                      child: Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ],
          ),
          endDrawer: MenuUp(context),
          //Menu principal
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              _onItemTapped(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Color(0xFFFFC600),
            selectedItemColor: Color(0xFFFFC600),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                activeIcon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_work),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: '',
              ),
            ],
          ),
        ),
        Visibility(
          visible: _menuVisible,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (_menuVisible) {
                    setState(() {
                      _menuVisible = false;
                    });
                  }
                },
                child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                  )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                  child: Container(
                      child: Scaffold(
                        body: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              ProfileName(),
                              Divider(color: Color(0xFFFFC600)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 20.0, 8.0, 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock_outline,
                                        color: Colors.grey),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Text("Politicas de privacidad"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.question_answer_outlined,
                                        color: Colors.grey),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Text("Preguntas frecuentes"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.settings, color: Colors.grey),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Text("Configuración"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.menu_book, color: Colors.grey),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Text("Tutorial"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.logout, color: Colors.grey),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Text("Cerrar sesión"),
                                    ),
                                  ],
                                ),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Home0 extends StatelessWidget {
  Future<Platos> _loadContent() async {
    print("LOADING CONTENTS.............");
    var res = await Network().getData('platos');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(res.statusCode);
      print(body['platos'][0]['clase']);
      print("platosFromJson: ${platosFromJson(res.body)}");
      return platosFromJson(res.body);
    } else {
      print(res.statusCode);
      throw Exception(
          "Error al descargar datos desde el servidor ${res.statusCode}");
    }
  } // _loadContent

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color(0xFFFAFCFA),
        child: FutureBuilder(
            future: _loadContent(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                print("Data: ${snapshot.data}");
                return PlatoItems(snapshot.data.platos);
              }
            }),
      ),
    );
  }
}
