class Review {
  final String id;
  final String restaurantId;
  final String userId;
  final double rating;
  final String comment;

  Review({required this.id, required this.restaurantId, required this.userId, required this.rating, required this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      restaurantId: json['restaurantId'],
      userId: json['userId'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
    };
  }
}
