import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wordpress_book_app/ui/Login.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HttpClientService{
  final String _baseUrl = 'http://10.0.2.2:8099';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> getToken() async{
    return await _storage.read(key: 'auth_token');
  }

  Future<http.Response> get(BuildContext context, String endpoint) async{
    final token = await getToken();


    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Adiciona o token no header
      }
    );

    if(_isTokenExpired(response)){
      await _logout(context);
    }

    return response;

  }

  Future<http.Response> put(
      BuildContext context, String endpoint,
      {Map<String, String>? headers, String? body}) async {

    final token = await getToken();


    String userId ='';





    // Fazendo a requisição PUT
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        ...?headers,
      },
      body: body,
    );

    // Checando se o token expirou
    if (_isTokenExpired(response)) {
      await _logout(context);
    }

    return response;
  }

  bool _isTokenExpired(http.Response response){
    return response.statusCode == 401; //se der 401 significa que o token expirou
  }

  Future<void> _logout(BuildContext context) async{
    await _storage.delete(key: 'auth_token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false

    );

  }

  Future<http.Response> delete(BuildContext context, String endpoint) async {
    final token = await getToken();

    final response = await http.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    // checando se o token expirou
    if(_isTokenExpired(response)){
      await _logout(context);
    }

    return response;

  }

  Future<http.Response> post(
      BuildContext context,
      String endpoint,
      String body, {
        Map<String, String>? headers,

  }
      ) async{
    final token = await getToken();

    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        ...?headers,
      },
      body: body,
    );

    //Verifica se o token expirou
    if(_isTokenExpired(response)){
      await _logout(context);
    }

    return response;
  }
}