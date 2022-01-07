// To parse this JSON data, do
//
//     final platos = platosFromJson(jsonString);

import 'dart:convert';

Platos platosFromJson(String str) => Platos.fromJson(json.decode(str));

String platosToJson(Platos data) => json.encode(data.toJson());

class Platos {
  Platos({
    this.platos,
    this.message,
  });

  List<Plato> platos;
  String message;

  factory Platos.fromJson(Map<String, dynamic> json) => Platos(
    platos: List<Plato>.from(json["platos"].map((x) => Plato.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "platos": List<dynamic>.from(platos.map((x) => x.toJson())),
    "message": message,
  };
}

class Plato {
  Plato({
    this.id,
    this.idUser,
    this.name,
    this.resto,
    this.review,
    this.location,
    this.score,
    this.precio,
    this.image,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
    this.autorName,
    this.autorMail,
    this.autorImage,
  });

  int id;
  int idUser;
  String name;
  String resto;
  String review;
  String location;
  String score;
  int precio;
  String image;
  String lat;
  String lng;
  DateTime createdAt;
  DateTime updatedAt;
  String autorName;
  String autorMail;
  String autorImage;

  factory Plato.fromJson(Map<String, dynamic> json) => Plato(
    id: json["id"],
    idUser: json["id_user"],
    name: json["name"],
    resto: json["resto"],
    review: json["review"],
    location: json["location"],
    score: json["score"],
    precio: json["precio"],
    image: json["image"],
    lat: json["lat"],
    lng: json["lng"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    autorName: json["autor_name"],
    autorMail: json["autor_mail"],
    autorImage: json["autor_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "name": name,
    "resto": resto,
    "review": review,
    "location": location,
    "score": score,
    "precio": precio,
    "image": image,
    "lat": lat,
    "lng": lng,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "autor_name": autorName,
    "autor_mail": autorMail,
    "autor_image": autorImage,
  };
}
