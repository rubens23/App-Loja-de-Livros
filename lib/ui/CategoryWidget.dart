import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget{
  final String imgGenero;
  final String nomeGenero;

  const CategoryWidget(
      {
        Key? key,
        required this.imgGenero,
        required this.nomeGenero
      }
      ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Container(
          width: 160,
          height: 160,

          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            image: DecorationImage(
              image: NetworkImage(imgGenero),
              fit: BoxFit.fill,

            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4)
              )
            ],
          ),

        ),
        SizedBox(height: 10,),
        Text(nomeGenero, style: TextStyle(fontFamily: 'Roboto', fontSize: 24, color: Color(0xFF707070)
        ),)
      ],
    );
  }




}