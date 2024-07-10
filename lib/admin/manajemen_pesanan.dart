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

  void _showAddOrderDialog() {
    final orderIdController = TextEditingController();
    final statusController = TextEditingController();
    final totalAmountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Pesanan Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: orderIdController,
                decoration: const InputDecoration(labelText: 'ID Pesanan'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: totalAmountController,
                decoration: const InputDecoration(labelText: 'Total Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final orderId = orderIdController.text.trim();
                final status = statusController.text.trim();
                final totalAmountString = totalAmountController.text.trim();
                final totalAmount = double.tryParse(totalAmountString);

                if (orderId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID Pesanan tidak boleh kosong')),
                  );
                } else if (status.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Status tidak boleh kosong')),
                  );
                } else if (totalAmountString.isEmpty || totalAmount == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Total Amount harus berupa angka yang valid')),
                  );
                } else {
                  try {
                    await _firestore.collection('orders').add({
                      'id': orderId,
                      'status': status,
                      'totalAmount': totalAmount,
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menambahkan pesanan: $e')),
                    );
                  }
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOrderDialog,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Pesanan Baru',
      ),
    );
  }
}
