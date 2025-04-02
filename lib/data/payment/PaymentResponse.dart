import 'package:wordpress_book_app/data/utils/jsonUtils.dart';

class PaymentResponse {
  final String id;
  final String orderId;
  final String userId;
  final double amount;
  final String paymentMethod; // Ex.: "pix", "credit_card"
  final String status; // Ex.: "pending", "completed", "failed"
  final String? transactionId; // ID fornecido pelo gateway de pagamento
  final int createdAt;
  final Map<String, dynamic> details;
  final String? pixPaymentId;
  final String? creditCardPaymentId;

  PaymentResponse({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.transactionId,
    required this.createdAt,
    required this.details,
    required this.pixPaymentId,
    required this.creditCardPaymentId,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: safeParse(json['id'], 'id', 'PaymentResponse'),
      orderId: safeParse(json['orderId'], 'orderId', 'PaymentResponse'),
      userId: safeParse(json['userId'], 'userId', 'PaymentResponse'),
      amount: safeParse(json['amount'], 'amount', 'PaymentResponse'),
      paymentMethod: safeParse(json['paymentMethod'], 'paymentMethod', 'PaymentResponse'),
      status: safeParse(json['status'], 'status', 'PaymentResponse'),
      transactionId: safeParse(json['transactionId'], 'transactionId', 'PaymentResponse'),
      createdAt: safeParse(json['createdAt'], 'createdAt', 'PaymentResponse'),
      details: json['details'] != null ? Map<String, dynamic>.from(json['details']) : {},
      pixPaymentId: safeParse(json['pixPaymentId'], 'pixPaymentId', 'PaymentResponse'),
      creditCardPaymentId: safeParse(json['creditCardPaymentId'], 'creditCardPaymentId', 'PaymentResponse'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'status': status,
      'transactionId': transactionId,
      'createdAt': createdAt,
      'details': details,
      'pixPaymentId': pixPaymentId,
      'creditCardPaymentId': creditCardPaymentId,
    };
  }
}
