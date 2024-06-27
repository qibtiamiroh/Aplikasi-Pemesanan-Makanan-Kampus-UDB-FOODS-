// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/model/data_ulasan_model.dart';

class ReviewManagementPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void deleteReview(String reviewId) async {
    await _firestore.collection('reviews').doc(reviewId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Ulasan dan Rating'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final reviews = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Review.fromJson({...data, 'id': doc.id});
          }).toList();

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ListTile(
                title: Text('Rating: ${review.rating.toString()}'),
                subtitle: Text(review.comment),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteReview(review.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
