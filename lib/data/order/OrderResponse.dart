import 'package:wordpress_book_app/data/cart/CartItem.dart';
import 'package:wordpress_book_app/data/order/OrdemItemResponse.dart';
import 'package:wordpress_book_app/data/user/Address.dart';

import '../utils/jsonUtils.dart';

class OrderResponse{
  final String id;
  final String userId;
  final List<OrderItemResponse> items;
  final double totalAmount;
  final Address address;
  final String orderStatus;
  final int? updatedAt;
  final int createdAt;
  final List<String> paymentIds;
  final String paymentMethod;

  OrderResponse({required this.id, required this.userId, required this.items, required this.totalAmount, required this.address, required this.orderStatus, required this.updatedAt, required this.createdAt, required this.paymentIds, required this.paymentMethod});

  factory OrderResponse.fromJson(Map<String, dynamic> json){
    List<OrderItemResponse> items = [];
    
    Address address = Address.fromJson(json['address']);

    for (var itemJson in json['items']) {
      items.add(OrderItemResponse.fromJson(itemJson));
    }

    // Aqui, vamos extrair a lista de paymentIds diretamente do JSON
    List<String> paymentIds = json['paymentIds'] != null
        ? List<String>.from(json['paymentIds'])
        : [];

    return OrderResponse(id: safeParse(json['id'], 'id', 'OrderResponse'),
        userId: safeParse(json['userId'], 'userId', 'OrderResponse'),
        items: items,
        totalAmount: safeParse(json['totalAmount'], 'totalAmount', 'OrderResponse'),
        address: address,
        orderStatus: safeParse(json['orderStatus'], 'orderStatus', 'OrderResponse'),
        updatedAt: safeParse(json['updatedAt'], 'updatedAt', 'OrderResponse'),
        createdAt: safeParse(json['createdAt'], 'createdAt', 'OrderResponse'),
        paymentIds: paymentIds,
        paymentMethod: safeParse(json['paymentMethod'], 'paymentMethod', 'OrderResponse'));
  }

}