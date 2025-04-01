import 'package:wordpress_book_app/data/cart/Cart.dart';
import 'package:wordpress_book_app/data/user/Address.dart';

import '../payment/PaymentRequest.dart';
import '../payment/pix/PixPaymentResponse.dart';

class OrderRequest{
  final Cart userCart;
  final PaymentRequest payment;
  final Address addressDto;
  final PixPaymentResponse pixResponse;

  OrderRequest({required this.userCart, required this.payment, required this.addressDto, required this.pixResponse});

  Map<String, dynamic> toJson() {
    return {
      'userCart': userCart,
      'payment': payment,
      'addressDto': addressDto,
      'pixResponse': pixResponse,

    };
  }




}