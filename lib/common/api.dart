import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
//import "package:shared_preferences/shared_preferences.dart";
class CallApi{
  postData(data, apiUrl) async {
    var fullUrl = url_server + apiUrl ;
    var request = await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
    return json.decode(request.body);
  }
  getData(apiUrl) async {
    var fullUrl = url_server + apiUrl;
    var request =  await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
    return json.decode(request.body);
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   return '?token=$token';
  // }
  getArticles(apiUrl) async {
    http.Response response = await http.get(
        Uri.parse(url_server+apiUrl)) ;
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }
  getPublicData(apiUrl) async {
    http.Response response = await http.get(
        Uri.parse(url_server+apiUrl)) ;
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }
}