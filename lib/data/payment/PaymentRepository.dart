import 'package:flutter/cupertino.dart';
import 'package:wordpress_book_app/data/api/ApiService.dart';
import 'package:wordpress_book_app/data/order/OrderRequest.dart';
import 'package:wordpress_book_app/data/order/OrderResponse.dart';
import 'package:wordpress_book_app/data/payment/pix/PixPaymentRequest.dart';
import 'package:wordpress_book_app/data/payment/pix/PixPaymentResponse.dart';

import '../api/Result.dart';
import '../cart/Cart.dart';
import '../user/Address.dart';
import '../user/User.dart';
import 'PaymentRequest.dart';

class PaymentRepository{
  final ApiService _apiService = ApiService();


  Future<PixPaymentResponse?> payByPix(String cpf, double valor, BuildContext context) async{
    try{
      User? user = await _apiService.getUserById(context);

      if(user == null){
        print("User não encontrado no repositorio PayResponse no metodo PayByPix");
        return null;
      }

      PixPaymentRequest request = PixPaymentRequest(userId: user.id,
          nome: user.name,
          email: user.email,
          cpf: cpf,
          valor: valor);

      return await _apiService.payByPix(request, context);

    }catch(error){
      print("error in payment repository payByPix $error");
      return null;
    }
  }

  Future<Result<OrderResponse>> makeNewOrder(
      Cart userCart,
      Address addressDto,
      BuildContext context) async{
    try{
      OrderRequest orderRequest = OrderRequest(
          userCart: userCart,
          addressDto: addressDto);

      return await _apiService.makeNewOrder(orderRequest, context);


    }catch(error){
      print("error in payment repository makeNewOrder $error");
      return Result.failure("Ocorreu um erro ao gerar o pedido.");

    }
  }

  Future<PixPaymentResponse?> getPaymentDetails(BuildContext context, String paymentId) async{
    try{
      PixPaymentResponse? response = await _apiService.getPixPaymentDetails(context, paymentId);
      return response;

    }catch(error){
      print("error in payment repository $error");
      return null;
    }
  }

  Future<void> updateOrderWithPix(String orderId, PixPaymentResponse pixPaymentResponse, BuildContext context) async{
    try{
      await _apiService.updateOrderWithPix(orderId, pixPaymentResponse, context);

    }catch(error){
      print("error in payment repository updateOrderWithPix $error");
    }

  }
}