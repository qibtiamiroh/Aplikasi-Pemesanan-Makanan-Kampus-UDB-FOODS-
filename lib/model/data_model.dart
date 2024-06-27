import 'package:cloud_firestore/cloud_firestore.dart';

class SalesReport {
  final String id;
  final String restaurantId;
  final double totalSales;
  final DateTime date;

  SalesReport({required this.id, required this.restaurantId, required this.totalSales, required this.date});

  factory SalesReport.fromJson(Map<String, dynamic> json) {
    return SalesReport(
      id: json['id'],
      restaurantId: json['restaurantId'],
      totalSales: json['totalSales'],
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'totalSales': totalSales,
      'date': date,
    };
  }
}
