import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/book/Book.dart';
import '../data/book/BooksRepository.dart';
import '../data/book/Genero.dart';
import '../main.dart';
import 'Books.dart';

class MyHomePage extends StatefulWidget {




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BooksRepository booksRepository = BooksRepository();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Círculo verde que ocupa toda a largura da tela

          SingleChildScrollView(
              child: Column(
                children: [

                  FutureBuilder<Map<String, dynamic>>(
                    future: booksRepository.fetchBooksAndGenres(context),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }else if(snapshot.hasError){
                        return Center(child: Text('Error loading books'));
                      }else if (snapshot.hasData){
                        final data = snapshot.data!;
                        final List<Book> books = data['books'];
                        final List<Genero> generos = data['generos'];
                        return Books(books: books, generos: generos);






                      }else{
                        return Center(child : Text('Ocorreu um erro no carregamento dos livros', style: TextStyle(fontFamily: 'Roboto'),));
                      }
                    },

                  ),
                ],
              )

          )
        ],
      ),
      appBar: AppBar(
        title: const Text(
          'Book App',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 23,
          ),
        ),
        backgroundColor: const Color(0xFF5ABD8C),
        leading: Builder(
          builder: (context){
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 36,),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: (){
              print('Icone de pesquisa pressionado');
            },
            iconSize: 36,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF5ABD8C),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: (){

                Navigator.pop(context);

              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: (){

                Navigator.pop(context);

              },
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}