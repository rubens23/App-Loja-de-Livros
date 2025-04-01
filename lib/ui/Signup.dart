import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/ui/colors.dart';
import '../auth/Auth.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Campo de texto para o E-mail
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E-mail',
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
                controller: _emailController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
          
              // Campo de texto para o Nome de Usuário
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nome',
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
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
          
              // Campo de texto para a Senha
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
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
          
              // Campo de texto para Confirmar Senha
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmar Senha',
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
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
          
              // Botão de Cadastro
              ElevatedButton(
                onPressed: _signup,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 10),
          
              // Link para tela de Login
              Padding(
                padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Já tem uma conta? Faça login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função chamada quando o botão de cadastro é pressionado
  void _signup() {
    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;


    if (email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, preencha todos os campos'),
      ));
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('As senhas não coincidem'),
      ));
    } else {
      // Lógica de registro
      _authService.register(context, username, email, password, confirmPassword);



    }
  }
}
