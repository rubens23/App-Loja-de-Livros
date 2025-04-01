import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wordpress_book_app/ui/Login.dart';

import 'Signup.dart';
import 'colors.dart';

class InitialScreen extends StatelessWidget {
  void _goToLogin(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        )
    );
  }

  void _goToSignup(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupPage(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botão de Login com tamanho fixo
            SizedBox(
              width: 250, // Tamanho fixo horizontal
              child: ElevatedButton(
                onPressed: () => _goToLogin(context),
                child: Text(
                  'Login',
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Espaçamento entre os botões
            // Botão de Signup com borda, sem preenchimento
            SizedBox(
              width: 250, // Tamanho fixo horizontal
              child: ElevatedButton(
                onPressed: () => _goToSignup(context),
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor, // Cor do texto
                  side: BorderSide(color: AppColors.primaryColor, width: 2), // Borda colorida
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/initial_screen.svg',
                fit: BoxFit.contain,  // Ajuste para garantir que a imagem se ajuste ao espaço disponível
              ),
            ),
          ],
        ),
      ),
    );
  }
}