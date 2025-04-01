import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/user/Address.dart';
import 'colors.dart';

class AddressScreen extends StatefulWidget{
  final Address? address;

  const AddressScreen({super.key, this.address});

  @override
  _AddressScreenState createState() => _AddressScreenState();

}

class _AddressScreenState extends State<AddressScreen>{
  final TextEditingController rua = TextEditingController();
  final TextEditingController cidade = TextEditingController();
  final TextEditingController estado = TextEditingController();
  final TextEditingController cep = TextEditingController();
  final TextEditingController pais = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,title: Text("Endereço", style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),),),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Campo de texto para o usuário
            Padding(
              padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rua',
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
              controller: rua,
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
            // Campo de texto para o usuário
            Padding(
              padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cidade',
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
              controller: cidade,
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
            // Campo de texto para o usuário
            Padding(
              padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Estado',
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
              controller: estado,
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
            // Campo de texto para o usuário
            Padding(
              padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CEP',
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
              controller: cep,
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
            // Campo de texto para o usuário
            Padding(
              padding: EdgeInsets.only(left: 10.0), // Adiciona margem à esquerda
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'País',
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
              controller: pais,
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
            SizedBox(height: 40),
            // Botão de salvar endereço
            SizedBox(
              width: double.infinity, // Ocupa toda a largura disponível
              child: ElevatedButton(
                onPressed: _salvarEndereco,
                child: Text(
                  'Salvar Endereço',
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
                  padding: EdgeInsets.symmetric(vertical: 10.0)
                ),
              ),
            ),

          ],
        ),
      ),),
    );
  }
  

  void _salvarEndereco() {
  }
}