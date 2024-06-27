// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, use_key_in_widget_constructors, library_prefixes

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/model/pesanan_model.dart' as PesananModel;

class OrderManagementPage extends StatefulWidget {
  @override
  _OrderManagementPageState createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({'status': status});
  }

  void processRefund(String orderId) async {
     try {
      await Future.delayed(const Duration(seconds: 2)); 
      await _firestore.collection('orders').doc(orderId).update({'status': 'Dibatalkan'});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Refund telah diproses untuk order $orderId')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal memproses refund: $e')));
    }
  }

  void resolveComplaint(String orderId, String complaint) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _firestore.collection('orders').doc(orderId).update({'complaint': complaint});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Komplain untuk order $orderId telah ditangani')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menangani komplain: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Pesanan'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return PesananModel.Order.fromJson({...data, 'id': doc.id}); // Menggunakan alias
          }).toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text('Order ${order.id}'),
                subtitle: Text('Status: ${order.status} - Total: \$${order.totalAmount.toString()}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      value: order.status,
                      items: ['Baru', 'Diproses', 'Selesai', 'Dibatalkan'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          updateOrderStatus(order.id, newStatus);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.money_off),
                      onPressed: () => processRefund(order.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          final complaintController = TextEditingController(text: order.complaint);
                          return AlertDialog(
                            title: const Text('Resolusi Komplain'),
                            content: TextField(
                              controller: complaintController,
                              decoration: const InputDecoration(labelText: 'Komplain'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Batal'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  resolveComplaint(order.id, complaintController.text);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Simpan'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}