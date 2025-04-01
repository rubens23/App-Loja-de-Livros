import '../book/Book.dart';
import '../utils/jsonUtils.dart';

class CartItem {
  final String userId;
  final String productId;
  final int quantity;
  final double price;
  final Book book;
  final String itemType;

  CartItem({
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.book,
    required this.itemType,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: safeParse<String>(json['userId'], 'userId', 'CartItem'),
      productId: safeParse<String>(json['productId'], 'productId', 'CartItem'),
      quantity: safeParse<int>(json['quantity'], 'quantity', 'CartItem'),
      price: safeParse<double>(json['price'], 'price', 'CartItem'),
      itemType: safeParse<String>(json['itemType'], 'itemType', 'CartItem'),
      book: json['bookResponse'] != null ? Book.fromJson(json['bookResponse']) : throw Exception("Erro: campo 'book' ausente"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'bookResponse': book.toJson(), // Certifique-se de que a classe Book também tenha um toJson()
      'itemType': itemType
    };
  }
}