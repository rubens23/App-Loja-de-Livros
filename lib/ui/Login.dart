import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/ui/colors.dart';

import '../auth/Auth.dart';
import '../data/api/ApiService.dart';
import '../main.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage>{

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Campo de texto para o usuário
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Usuário',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2)
                  )
                ),
              ),
              SizedBox(height: 20),
          
              // Campo de texto para a senha
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Senha',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.primaryColor, width: 2)
                    )
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      color: AppColors.primaryTextColor
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
          
              // Botão de Login
              ElevatedButton(
                onPressed: _login,
                child: Text('Login',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
              ),
          
            ],
          ),
        ),
      ),

    );
  }

  // Função chamada quando o botão de login é pressionado
  void _login(){
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    //isso aqui vai ficar aqui só enquanto eu faço as telas
    final ApiService booksApiService = ApiService();


    if(username.isEmpty || password.isEmpty){

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content: Text('Por favor, preencha todos os campos'),));
    }else{
      _authService.login(context, username, password);
    }
  }
  
}

