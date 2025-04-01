import 'package:flutter/cupertino.dart';

import 'Book.dart';
import '../api/ApiService.dart';
import 'Genero.dart';

class BooksRepository {
  final ApiService booksApiService = ApiService();



  Future<Map<String, dynamic>> fetchBooksAndGenres(BuildContext context) async {
    try {
      final books = booksApiService.fetchBooks(context);
      final genres = booksApiService.fetchGeneros();

      final results = await Future.wait([books, genres]);

      return {
        'books': results[0] as List<Book>,
        'generos': results[1] as List<Genero>,
      };
    } catch (error) {
      print('Error loading books or genres $error');
      rethrow;
    }
  }

  Future<Book?> fetchBookById(BuildContext context, String bookId) async {
    try {
     return await booksApiService.fetchBookById(context, bookId);



    } catch (error) {
      print('Error loading books or genres $error');
      return null;
    }
  }


  Future<List<String>> getUnavailableBooksList(List<String>? bookIds, BuildContext context) async{
    try{
      //print("getUnavailableBooksList foi chamado. bookIds ${bookIds?[0]} ${bookIds?[1]}");
      return await booksApiService.fetchUnavailableBooksList(bookIds, context);

    }catch(error){
      print("Error getting unavailable books $error");
      return [];
    }
  }
}