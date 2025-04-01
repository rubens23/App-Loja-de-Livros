import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_book_app/ui/colors.dart';

class Successfulpurchasescreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
                child: IconButton(onPressed: _closeScreen,
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    size: 50,))
            ),
            Spacer(),

            Icon(
              Icons.check_circle, color: Colors.black,
              size: 100,
            ),

            SizedBox(height: 40,),


            Text("Parabéns!", style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 50,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("Your purchase was successful", style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryTextColor
                  ),),

            SizedBox(height: 40,),

            Text("ID do Pedido: 1234567", style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryTextColor
            ),),

            SizedBox(height: 40,),

            ElevatedButton(
              onPressed: _goToHome,
              child: Text('Continuar comprando',
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


            Spacer()





          ],
        ),
      ),
    );
  }


  void _closeScreen() {
  }

  void _goToHome() {
  }
}