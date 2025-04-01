import 'package:flutter/cupertino.dart';
import 'package:wordpress_book_app/data/api/ApiService.dart';

class WishlistRepository {
  final ApiService _apiService = ApiService();

  Future<bool> addBookToWishlist(BuildContext context, String bookId) async {
    try {
      // Chama a API para adicionar o livro à wishlist
      await _apiService.addToWishList(context,bookId);
      return true;
    } catch (error) {
      print('Erro ao adicionar livro à wishlist: $error');
      return false;
    }
  }

  Future<bool> removeBookFromWishlist(BuildContext context, String bookId) async {
    try {
      // Chama a API para remover o livro da wishlist
      await _apiService.removeFromWishlist(context, bookId);
      return true;
    } catch (error) {
      print('Erro ao remover livro da wishlist: $error');
      return false;
    }
  }

  Future<List<String>?> fetchWishlistByUser(BuildContext context) async {
    try {
      // Chama a API para obter a wishlist do usuário
      final wishlist = await _apiService.getWishlistByUser(context);
      return wishlist;
    } catch (error) {
      print('Erro ao buscar wishlist: $error');
      return null;
    }
  }

  Future<bool> isBookInWishlist(BuildContext context, String bookId) async {
    try {
      // Chama a API para verificar se o livro está na wishlist
      final wishlist = await _apiService.getWishlistByUser(context);

      return wishlist.contains(bookId); // Verifica se o ID do livro está na lista
        } catch (error) {
      print('Erro ao verificar livro na wishlist: $error');
      return false;
    }
  }
}