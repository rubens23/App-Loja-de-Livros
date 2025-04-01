import '../book/Book.dart';
import '../utils/jsonUtils.dart';
import 'CartItem.dart';

class Cart {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> items = [];

    for (var itemJson in json['items']) {
      items.add(CartItem.fromJson(itemJson));
    }

    return Cart(
      id: safeParse<String>(json['id'], 'id', 'Cart'),
      userId: safeParse<String>(json['userId'], 'userId', 'Cart'),
      items: items,
      totalAmount: safeParse<double>(json['totalAmount'], 'totalAmount', 'Cart'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
    };
  }
}