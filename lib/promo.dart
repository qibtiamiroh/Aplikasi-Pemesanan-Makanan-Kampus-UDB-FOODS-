// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('promos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('Error loading promo data'));
          }

          final promos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: promos.length,
            itemBuilder: (context, index) {
              final promo = promos[index];
              final data = promo.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title'] ?? 'No Title'),
                subtitle: Text(data['description'] ?? 'No Description'),
              );
            },
          );
        },
      ),
    );
  }
}
