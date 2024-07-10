class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final String status; // Baru, Diproses, Selesai, Dibatalkan
  final double totalAmount;
  final String complaint;

  Order(
      {required this.id,
      required this.userId,
      required this.restaurantId,
      required this.status,
      required this.totalAmount,
      required this.complaint});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      restaurantId: json['restaurantId'],
      status: json['status'],
      totalAmount: json['totalAmount'],
      complaint: json['complaint'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'status': status,
      'totalAmount': totalAmount,
      'complaint': complaint,
    };
  }
}
