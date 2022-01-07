import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final String _texto;
  final bool pwd;
  final Color line;

  LoginInput(this._texto, {this.pwd = false, this.line = Colors.white});

  /*const LoginInput({
    Key key,
  }) : super(key: key);
*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextFormField(
        obscureText: pwd,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value.isEmpty) {
            return 'Por favor llena todos los campos';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: _texto,
          hintStyle: TextStyle(),
          contentPadding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          fillColor: Color(0xFFFFFFFF),
          filled: true,
        ),
      ),
    );
  }
}
