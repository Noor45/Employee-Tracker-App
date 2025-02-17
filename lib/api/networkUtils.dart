import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  registerManagerWithImage(String name, String email, String password,
      File image, String companyId) async {
    try {
      var url = Uri.https('localhost', 'api/manager/register');

      var request = http.MultipartRequest('POST', url)
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['company_token'] = companyId
        ..files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await http.Response.fromStream(await request.send());
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  registerEmployeeWithImage(String name, String email, String password,
      File image, String companyId) async {
    try {
      var url = Uri.https('localhost', 'api/employee/register');

      var request = http.MultipartRequest('POST', url)
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['company_token'] = companyId
        ..files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await http.Response.fromStream(await request.send());
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  post(String url, {Map<String, String>? headers, body, encoding}) {
    try {
      var URL = Uri.https('localhost', url);
      return http.post(URL, body: body, headers: headers, encoding: encoding);
    } catch (e) {
      print(e);
    }
  }

  

  
}
