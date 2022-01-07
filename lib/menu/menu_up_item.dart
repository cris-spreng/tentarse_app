import 'package:flutter/material.dart';

class MenuUpItem extends StatelessWidget {
  final Icon icon;
  final String text;
  MenuUpItem({this.icon, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:35,right:15),
      height: 40,
      child: ListTile(
        contentPadding:EdgeInsets.all(0),
        leading: icon,
        selected: false,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0) ,
         // alignment: Alignment(-1,0),
          child: Text(text),),
      ),
    );
  }
}
