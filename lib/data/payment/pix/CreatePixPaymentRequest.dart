import 'package:wordpress_book_app/data/utils/jsonUtils.dart';
import 'PixPaymentResponse.dart';

class CreatePixPaymentRequest {
  final String orderId;
  final PixPaymentResponse pixPaymentResponse;

  CreatePixPaymentRequest({
    required this.orderId,
    required this.pixPaymentResponse,
  });

  factory CreatePixPaymentRequest.fromJson(Map<String, dynamic> json) {
    return CreatePixPaymentRequest(
      orderId: safeParse(json['orderId'], 'orderId', 'CreatePixPaymentRequest'),
      pixPaymentResponse: PixPaymentResponse.fromJson(
          safeParse(json['pixPaymentResponse'], 'pixPaymentResponse', 'CreatePixPaymentRequest')),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'pixPaymentResponse': pixPaymentResponse.toJson(),
    };
  }
}