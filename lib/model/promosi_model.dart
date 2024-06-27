import 'package:cloud_firestore/cloud_firestore.dart';

class Promotion {
  final String id;
  final String code;
  final double discount;
  final DateTime expiryDate;

  Promotion({required this.id, required this.code, required this.discount, required this.expiryDate});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      code: json['code'],
      discount: json['discount'],
      expiryDate: (json['expiryDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discount': discount,
      'expiryDate': expiryDate,
    };
  }
}
