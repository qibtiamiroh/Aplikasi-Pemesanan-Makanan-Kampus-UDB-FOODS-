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

  double _calculateTotalSales(List<SalesReport> reports) {
    return reports.fold(0.0, (sum, report) => sum + report.totalSales);
  }

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
            return const Center(child: CircularProgressIndicator());
          }
          final reports = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return SalesReport.fromJson({...data, 'id': doc.id});
          }).toList();

          final totalSales = _calculateTotalSales(reports);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Penjualan: \$${totalSales.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    final report = reports[index];
                    return ListTile(
                      title: Text('Laporan ${report.id}'),
                      subtitle: Text(
                        'Total Penjualan: \$${report.totalSales.toString()} - Tanggal: ${report.date.toLocal()}'
                            .split(' ')[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
