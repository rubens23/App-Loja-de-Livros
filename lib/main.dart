import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wordpress_book_app/ui/InitialScreen.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page', booksApiService: booksApiService),
      home: InitialScreen(),
      //home: InitialScreen(),
      //home: MyScrollableWidget()
      //home: MyScrollablePage(),
    );
  }
}























