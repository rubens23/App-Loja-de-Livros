import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wordpress_book_app/main.dart';
import 'package:wordpress_book_app/ui/Login.dart';

import '../ui/MyHomePage.dart';


class AuthService {

  final String _loginUrl = 'http://10.0.2.2:8099/login';
  final String _registerUrl = 'http://10.0.2.2:8099/registerNewUser';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> login(BuildContext context, String email, String password) async {
    try{
      print("entrei no login");

      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        })


      );

      if(response.statusCode == 200){
        final responseBody = json.decode(response.body);
        final String token = responseBody['token'];

        print("token gerado no login $token");

        // Armazenando o token
        await _storage.write(key: 'auth_token', value: token);

        print("Login bem-sucedido");

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            )
        );

      }else if(response.statusCode == 401){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email ou senha inválidos.'),));

  }else{
        print("Erro no login: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao fazer login. Tente Novamente mais tarde!'),));

      }

    }catch(e){
      print("Erro ao fazer login: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao fazer login. Tente Novamente mais tarde!'),));

    }


   }

   Future<void> register(BuildContext context, String name, String email, String password, String confirmPassword) async{
    if(password != confirmPassword){
      print("As senhas não coincidem");
      return;
    }

    // Dados do usuário para envio
     final userData = {
      'name': name,
       'email': email,
       'password': password,
     };
    try{
      final response = await http.post(
        Uri.parse(_registerUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      if(response.statusCode == 200){
        print("Cadastro realizado com sucesso!");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cadastrado com sucesso!'),
        ));

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            )
        );

      }else{
        print("Erro ao registrar user ${response.statusCode}");


      }

    }catch(e){
      print("Erro ao registrar novo usuário: $e");
    }
   }

}