import 'package:wordpress_book_app/data/utils/jsonUtils.dart';

class PixPaymentResponse{
  final int id;
  final String status;
  final String statusDetail;
  final String? qrCode;
  final String? qrCodeBase64;
  final String? ticketUrl;

  PixPaymentResponse({required this.id,
    required this.status,
    required this.statusDetail,
    required this.qrCode,
    required this.qrCodeBase64,
    required this.ticketUrl});

  factory PixPaymentResponse.fromJson(Map<String, dynamic> json){
    return PixPaymentResponse(id: safeParse(json['id'], 'id', 'PixPaymentResponse'),
        status: safeParse(json['status'], 'status', 'PixPaymentResponse'),
        statusDetail: safeParse(json['statusDetail'], 'statusDetail', 'PixPaymentResponse'),
        qrCode: safeParse(json['qrCode'], 'qrCode', 'PixPaymentResponse'),
        qrCodeBase64: safeParse(json['qrCodeBase64'], 'qrCodeBase64', 'PixPaymentResponse'),
        ticketUrl: safeParse(json['ticketUrl'], 'ticketUrl', 'PixPaymentResponse'));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'statusDetail': statusDetail,
      'qrCode': qrCode,
      'qrCodeBase64': qrCodeBase64,
      'ticketUrl': ticketUrl,
    };
  }

}