import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final score;
  Stars(this.score);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: -4.0,
      children: [
        StarIcon(1,double.parse(score)),
        StarIcon(2,double.parse(score)),
        StarIcon(3,double.parse(score)),
        StarIcon(4,double.parse(score)),
        StarIcon(5,double.parse(score)),
      ],
    );
  }
}

class StarIcon extends StatelessWidget {
  final int _x;
  final double _score;

  StarIcon(this._x, this._score);

  @override
  Widget build(BuildContext context) {
    if(_score/_x>=1){
      return Icon(
        Icons.star_rounded,
        color:Color(0xFFFFC600),);
    }else if((_score*10)/_x>=7.5 && (_score*10)%2 != 0){
      return Icon(
        Icons.star_half_rounded,
        color:Color(0xFFFFC600));
    }else if(_x == 1 && _score >= 0.5){
      return Icon(
        Icons.star_half_rounded,
        color:Color(0xFFFFC600));
    }else{
      return Icon(
        Icons.star_border_rounded,
        color:Color(0xFF999999));
    }
  }
}
