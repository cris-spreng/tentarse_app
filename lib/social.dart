import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Social extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Crear cuenta con\n",
                style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFFFC600),),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex:6),
                  SocialIcon(
                    colors: [
                      Color(0xFF102397),
                      Color(0xFF187adf),
                      Color(0xFF00eaf8),
                    ],
                    iconBla: Icon(FontAwesomeIcons.facebookF,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                  Spacer(),
                  SocialIcon(
                    colors: [
                      Color(0xFFff4f38),
                      Color(0xFFff355d),
                    ],
                    iconBla:
                    Icon(FontAwesomeIcons.google, color: Colors.white),
                    onPressed: () {},
                  ),
                  Spacer(flex:6),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final List<Color> colors;
  final Icon iconBla;
  final Function onPressed;
  SocialIcon({this.colors, this.iconBla, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(right: 0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: colors, tileMode: TileMode.clamp)),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: iconBla,
        ),
      ),
    );
  }
}