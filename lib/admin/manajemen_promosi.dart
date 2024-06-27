// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/model/promosi_model.dart';

class PromotionManagementPage extends StatefulWidget {
  @override
  _PromotionManagementPageState createState() => _PromotionManagementPageState();
}

class _PromotionManagementPageState extends State<PromotionManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addPromotion(Promotion promotion) async {
    await _firestore.collection('promotions').add(promotion.toJson());
  }

  void updatePromotion(Promotion promotion) async {
    await _firestore.collection('promotions').doc(promotion.id).update(promotion.toJson());
  }

  void deletePromotion(String id) async {
    await _firestore.collection('promotions').doc(id).delete();
  }

  void showPromotionForm({Promotion? promotion}) {
    final codeController = TextEditingController(text: promotion?.code ?? '');
    final discountController = TextEditingController(text: promotion?.discount.toString() ?? '');
    DateTime expiryDate = promotion?.expiryDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(promotion == null ? 'Tambah Promosi' : 'Ubah Promosi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Kode Promosi'),
              ),
              TextField(
                controller: discountController,
                decoration: const InputDecoration(labelText: 'Diskon'),
                keyboardType: TextInputType.number,
              ),
              TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: expiryDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != expiryDate) {
                    setState(() {
                      expiryDate = picked;
                    });
                  }
                },
                child: const Text('Pilih Tanggal Kedaluwarsa'),
              ),
              Text('Tanggal Kedaluwarsa: ${expiryDate.toLocal()}'.split(' ')[0]),
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
              onPressed: () {
                final newPromotion = Promotion(
                  id: promotion?.id ?? DateTime.now().toString(),
                  code: codeController.text,
                  discount: double.parse(discountController.text),
                  expiryDate: expiryDate,
                );
                if (promotion == null) {
                  addPromotion(newPromotion);
                } else {
                  updatePromotion(newPromotion);
                }
                Navigator.of(context).pop();
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
        title: const Text('Manajemen Promosi'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('promotions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final promotions = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Promotion.fromJson({...data, 'id': doc.id});
          }).toList();

          return ListView.builder(
            itemCount: promotions.length,
            itemBuilder: (context, index) {
              final promotion = promotions[index];
              return ListTile(
                title: Text(promotion.code),
                subtitle: Text('Diskon: ${promotion.discount}% - Kedaluwarsa: ${promotion.expiryDate.toLocal()}'.split(' ')[0]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showPromotionForm(promotion: promotion),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deletePromotion(promotion.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPromotionForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
