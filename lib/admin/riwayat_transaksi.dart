// lib/screens/payment_integration_page.dart
// ignore_for_file: use_key_in_widget_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/transaksi_model.dart';

class PaymentIntegrationPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void cancelTransaction(String transactionId) async {
    await _firestore.collection('payment_transactions').doc(transactionId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrasi Pembayaran'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('payment_transactions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          }
          final transactions = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return PaymentTransaction.fromJson({...data, 'id': doc.id});
          }).toList();

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text('Transaksi ${transaction.id}'),
                subtitle: Text('Status: ${transaction.status} - Jumlah: \$${transaction.amount.toString()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => cancelTransaction(transaction.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
