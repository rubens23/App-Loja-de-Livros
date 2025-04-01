import 'package:wordpress_book_app/data/cart/Cart.dart';
import 'package:wordpress_book_app/data/user/Address.dart';

import '../payment/PaymentRequest.dart';
import '../payment/pix/PixPaymentResponse.dart';

class OrderRequest{
  final Cart userCart;
  final Address addressDto;


  OrderRequest({required this.userCart, required this.addressDto});

  Map<String, dynamic> toJson() {
    return {
      'userCart': userCart,
      'addressDto': addressDto,

    };
  }




}