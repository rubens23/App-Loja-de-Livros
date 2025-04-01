import '../utils/jsonUtils.dart';
import 'Address.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final Address? addresses;
  final int createdAt;
  final int? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.addresses,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: safeParse<String>(json['id'], 'id', 'User'),
      name: safeParse<String>(json['name'], 'name', 'User'),
      email: safeParse<String>(json['email'], 'email', 'User'),
      role: safeParse<String>(json['role'], 'role', 'User'),
      addresses: json['addresses'] != null ? Address.fromJson(json['addresses']) : null,
      createdAt: safeParse<int>(json['createdAt'], 'createdAt', 'User'),
      updatedAt: json['updatedAt'] != null ? safeParse<int>(json['updatedAt'], 'updatedAt', 'User') : null,
    );
  }
}