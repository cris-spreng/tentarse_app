
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Autor extends StatelessWidget {

  String _name = "Nombre";
  String _mail = "email@mail.com";
  String _url = "https://tentarse.com/public/storage/qwerty/user.png";

  Autor(this._name, this._mail, this._url);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
             // color: Colors.red,
            ),
            width: 40,
            height: 40,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl:_url,
                imageBuilder: (context, imageProvider) => Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),

              )
            )
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
