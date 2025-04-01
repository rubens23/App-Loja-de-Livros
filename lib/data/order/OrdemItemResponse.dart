import '../utils/jsonUtils.dart';

class OrderItemResponse{
  final String id;
  final String productId;
  final int quantity;
  final double price;

  OrderItemResponse({required this.id, required this.productId, required this.quantity, required this.price});


  factory OrderItemResponse.fromJson(Map<String, dynamic> json){
    return OrderItemResponse(id: safeParse(json['id'], 'id', 'OrderItemResponse'),
        productId: safeParse(json['productId'], 'productId', 'OrderItemResponse'),
        quantity: safeParse(json['quantity'], 'quantity', 'OrderItemResponse'),
        price: safeParse(json['price'], 'price', 'OrderItemResponse'));
  }
}