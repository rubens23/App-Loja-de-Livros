class PaymentRequest{
  final String status;
  final String paymentId;
  final String paymentMethod;

  PaymentRequest({required this.status, required this.paymentId, required this.paymentMethod});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'paymentId': paymentId,
      'paymentMethod': paymentMethod,
    };
  }
}