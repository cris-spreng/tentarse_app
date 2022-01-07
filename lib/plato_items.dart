import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cached_network_image/cached_network_image.dart';


import 'model/plato.dart';

import 'profile_name.dart';
import 'stars.dart';
import 'autor.dart';

class PlatoItems extends StatelessWidget {

  final List<Plato> platos;
  PlatoItems(this.platos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: platos.length,
        itemBuilder: (BuildContext context, int i){
          final platox = platos[i];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 9, 9, 0),
                child: Autor(platox.autorName, platox.autorMail, platox.autorImage),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        // ProfileName(),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
                              imageUrl:platox.image,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => CircularProgressIndicator(),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(platox.resto, style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                      ),),
                                    ), //NOMBRE RESTAURANT
                                    Stars(platox.score)
                                  ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(platox.name)), //NOMBRE PLATO
                                    Text("*****")
                                  ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(platox.precio.toString()), //PRECIO
                                    Text("*****")
                                  ],),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(platox.review)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          );

        }
    );
  }
}