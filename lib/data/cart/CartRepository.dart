import 'package:flutter/cupertino.dart';

import '../api/ApiService.dart';
import 'Cart.dart';

class CartRepository {
  final ApiService _apiService = ApiService();



  Future<bool> addBookToCart(BuildContext context, String bookId, int quantity, double price) async {
    try {
      return _apiService.saveBookInCart(context, bookId, quantity, price);

    } catch (error) {
      print('Error adding book to cart $error');
      return false;
    }
  }

  Future<bool> removeBookFromCart(BuildContext context, String bookId) async {
    try{
      return _apiService.removeBookFromCart(context, bookId);

    }catch(error){
      print('Error removing book from cart $error');
      return false;
    }
  }

  Future<Cart> fetchCartWithBooks(BuildContext context) async {
    try {
      final cart = await _apiService.getCart(context);
      return cart;
    } catch (error) {
      print('Error fetching cart: $error');
      return Future.error(error);
    }
  }


}