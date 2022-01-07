import 'package:flutter/material.dart';
import '../profile_name.dart';


class MenuUpHeader extends StatelessWidget {
  const MenuUpHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 182, //Alto del header
      child: DrawerHeader(
        child: Column(
          children: [
            SizedBox( //searchbar
              height: 30,
              child: TextFormField( //searchbar
                decoration:
                InputDecoration(
                  suffixIcon: Icon(Icons.search,color: Colors.white,),
                  contentPadding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor,
                  filled: true,
                ),
              ),
              width: double.infinity,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 1,
              height: 35.0,
            ),
            ProfileName(),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 1,
              height: 35.0,
            ),
          ],
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}