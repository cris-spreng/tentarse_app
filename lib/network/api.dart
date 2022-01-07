import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network{
  final String _url = 'https://tentarse.com/public/api/';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  authData(data, apiUrl) async {
    var fullUrl = Uri.parse(_url + apiUrl);
//    print(fullUrl);
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = Uri.parse(_url + apiUrl);
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  /*
  postPlato(data, file) async {
    var fullUrl = Uri.parse(_url + 'platos');
    await _getToken();
    return await http.MultipartRequest("POST",fullUrl)
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
*/
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}