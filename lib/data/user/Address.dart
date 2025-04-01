import '../utils/jsonUtils.dart';

class Address{
  final String id;
  final String userId;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;



  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: safeParse<String>(json['id'], 'id', 'Address'),
      userId: safeParse<String>(json['userId'], 'userId', 'Address'),
      street: safeParse<String>(json['street'], 'street', 'Address'),
      city: safeParse<String>(json['city'], 'city', 'Address'),
      state: safeParse<String>(json['state'], 'state', 'Address'),
      postalCode: safeParse<String>(json['postalCode'], 'postalCode', 'Address'),
      country: safeParse<String>(json['country'], 'country', 'Address'),
    );
  }

  Address({required this.id, required this.userId, required this.street, required this.city, required this.state, required this.postalCode, required this.country});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
}


