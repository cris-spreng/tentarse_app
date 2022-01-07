import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:location/location.dart';


import '../profile_name.dart';
import '../network/api.dart';
import '../home.dart';

class UploadServer extends StatefulWidget {
  final Uint8List imageData;

  UploadServer({Key key, this.imageData}) : super(key: key);

  @override
  _UploadServerState createState() => _UploadServerState();
}

class _UploadServerState extends State<UploadServer> {
  final Location location = Location();
  LocationData _location;
  Future<void> _getLocation() async {
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
        //print("Coords: ${_location.latitude} & ${_location.longitude}");
      });
    } on PlatformException catch (err) {
        //print("Error 2: $err");
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();

  }

  bool _processing = false;
  final _formKey = GlobalKey<FormState>();

  var plato, resto, review, id_user;

  double score = 3;
  double precio = 10000;

  _getUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Map<String, dynamic> user = jsonDecode(localStorage.getString('user'));
    return user['id'];
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return jsonDecode(localStorage.getString('token'));
  }

  _postPlato(file, int imgLength) async {
    this.setState(() {
      _processing = true;
    });


    var token = await _getToken();
    id_user = await _getUserId();

    Map<String, String> data = {
      'name': plato,
      'resto': resto,
      'review': review,
      'score': score.toString(),
      'precio': precio.toInt().toString(),
      'id_user': id_user.toString(),
      'location': 'dummy location',
      'lat': _location.latitude.toString(),
      'lng': _location.longitude.toString()

    };
    // print("NUTZ DATA: $data");
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://tentarse.com/public/api/platos"));
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data",
      'Accept': 'application/json'
    };
    request.files
        .add(http.MultipartFile.fromBytes('image', file, filename: "image"));
    request.headers.addAll(headers);
    request.fields.addAll(data);
    //print("request: "+request.toString());
    var res = await request.send();
    //print("This is response:"+res.statusCode.toString());
    if (res.statusCode == 201) {
      this.setState(() {
        _processing = false;
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
    } else {
      print("Upload falló!");
      this.setState(() {
        _processing = false;
      });
    }
  } // end _postPlato...

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 26.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Publicación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  File imagen = File.fromRawPath(widget.imageData);
                  //print("TAMAÑO IMAGEN: ${widget.imageData.lengthInBytes}");
                  _postPlato(widget.imageData, widget.imageData.lengthInBytes);
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileName(),
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: size.width, maxWidth: size.width),
                      child: Image.memory(
                        widget.imageData,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa el nombre del restaurant.';
                            }
                            resto = value;
                            return null;
                          },
                          decoration: InputDecoration(hintText: " Restaurant"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa el nombre de el plato.';
                            }
                            plato = value;
                            return null;
                          },
                          decoration: InputDecoration(hintText: " Plato"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFormField(
                          maxLength: 500,
                          maxLines: 4,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Todos los campos son requeridos.';
                            }
                            review = value;
                            return null;
                          },
                          decoration: InputDecoration(hintText: " Comentarios"),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  " Nota",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF646464)),
                                ),
                              )),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Color(0xFFFFC600),
                              inactiveTrackColor: Color(0xFFFAFAFA),
                              trackShape: RectangularSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbColor: Color(0xFFFFC600),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayColor: Color(0xFFFFB600),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: score,
                              min: 1,
                              max: 5,
                              divisions: 5,
                              label: score.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  score = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  " Precio",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF646464)),
                                ),
                              )),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Color(0xFFFFC600),
                              inactiveTrackColor: Color(0xFFFAFAFA),
                              trackShape: RectangularSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbColor: Color(0xFFFFC600),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayColor: Color(0xFFFFB600),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: precio,
                              min: 1000,
                              max: 20000,
                              divisions: 19,
                              label: "${precio.round().toString()}+",
                              onChanged: (double value) {
                                setState(() {
                                  precio = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
          (_processing) // Para bloquear pantalla mientras se sube el post
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black12
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
              : Center(),
        ],
      ),
    );
  }
}
