// lib/screens/app_settings_page.dart
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/model/pengaturan_model.dart';

class AppSettingsPage extends StatefulWidget {
  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateSettings(AppSettings settings) async {
    await _firestore.collection('app_settings').doc(settings.id).update(settings.toJson());
  }

  void showSettingsForm(AppSettings? settings) {
    final operationalHoursController = TextEditingController(text: settings?.operationalHours ?? '');
    final deliveryZoneController = TextEditingController(text: settings?.deliveryZone ?? '');
    final deliveryFeeController = TextEditingController(text: settings?.deliveryFee.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pengaturan Aplikasi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: operationalHoursController,
                decoration: const InputDecoration(labelText: 'Jam Operasional'),
              ),
              TextField(
                controller: deliveryZoneController,
                decoration: const InputDecoration(labelText: 'Zona Pengantaran'),
              ),
              TextField(
                controller: deliveryFeeController,
                decoration: const InputDecoration(labelText: 'Biaya Pengantaran'),
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
              onPressed: () {
                final newSettings = AppSettings(
                  id: settings?.id ?? DateTime.now().toString(),
                  operationalHours: operationalHoursController.text,
                  deliveryZone: deliveryZoneController.text,
                  deliveryFee: double.parse(deliveryFeeController.text),
                );
                updateSettings(newSettings);
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
        title: const Text('Pengaturan Aplikasi'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('app_settings').doc('default').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final settings = AppSettings.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Jam Operasional: ${settings.operationalHours}'),
              ),
              ListTile(
                title: Text('Zona Pengantaran: ${settings.deliveryZone}'),
              ),
              ListTile(
                title: Text('Biaya Pengantaran: \$${settings.deliveryFee.toString()}'),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => showSettingsForm(settings),
                  child: const Text('Ubah Pengaturan'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
