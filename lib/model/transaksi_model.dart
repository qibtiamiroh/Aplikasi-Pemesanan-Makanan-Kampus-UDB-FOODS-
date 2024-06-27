
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentTransaction {
  final String id;
  final String userId;
  final String restaurantId;
  final double amount;
  final DateTime timestamp;
  final String status;

  PaymentTransaction({required this.id, required this.userId, required this.restaurantId, required this.amount, required this.timestamp, required this.status});

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'],
      userId: json['userId'],
      restaurantId: json['restaurantId'],
      amount: json['amount'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'amount': amount,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
