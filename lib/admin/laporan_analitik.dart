// lib/screens/report_analytics_page.dart
// ignore_for_file: unnecessary_const, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/model/data_model.dart';

class ReportAnalyticsPage extends StatefulWidget {
  const ReportAnalyticsPage({super.key});

  @override
  _ReportAnalyticsPageState createState() => _ReportAnalyticsPageState();
}

class _ReportAnalyticsPageState extends State<ReportAnalyticsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan dan Analitik'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('sales_reports').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: const CircularProgressIndicator());
          }
          final reports = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return SalesReport.fromJson({...data, 'id': doc.id});
          }).toList();

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ListTile(
                title: Text('Laporan ${report.id}'),
                subtitle: Text('Total Penjualan: \$${report.totalSales.toString()} - Tanggal: ${report.date.toLocal()}'.split(' ')[0]),
              );
            },
          );
        },
      ),
    );
  }
}
