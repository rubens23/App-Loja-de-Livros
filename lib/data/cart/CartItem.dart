import '../book/Book.dart';
import '../utils/jsonUtils.dart';

class CartItem {
  final String userId;
  final String productId;
  final int quantity;
  final double price;
  final int stockQnt;
  final Book book;

  CartItem({
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.stockQnt,
    required this.book,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: safeParse<String>(json['userId'], 'userId', 'CartItem'),
      productId: safeParse<String>(json['productId'], 'productId', 'CartItem'),
      quantity: safeParse<int>(json['quantity'], 'quantity', 'CartItem'),
      price: safeParse<double>(json['price'], 'price', 'CartItem'),
      book: json['bookResponse'] != null ? Book.fromJson(json['bookResponse']) : throw Exception("Erro: campo 'book' ausente"),
      stockQnt: safeParse(json['stockQnt'], 'stockQnt', 'CartItem')
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'bookResponse': book.toJson(), // Certifique-se de que a classe Book também tenha um toJson()
      'stockQnt': stockQnt
    };
  }
}