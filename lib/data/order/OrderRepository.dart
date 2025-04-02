import 'package:flutter/cupertino.dart';
import 'package:wordpress_book_app/data/api/ApiService.dart';

class OrderRepository{
  final ApiService _apiService = ApiService();

  Future<void> updateOrderStatus(String orderId, Map<String, String> statusMap, BuildContext context) async{
    try{
      await _apiService.updateOrderStatus(orderId, statusMap, context);

    }catch(error){
      print("error in order repository in updateOrder");
    }
  }
}