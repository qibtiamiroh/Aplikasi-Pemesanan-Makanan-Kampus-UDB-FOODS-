import 'package:flutter/material.dart';

class Payment {
  final String title;
  final double amount;
  final String date;

  Payment({required this.title, required this.amount, required this.date});
}

List<Payment> payments = [
  Payment(title: 'Nasi Ayam Goreng', amount: 10000, date: '2024-05-01'),
  Payment(title: 'Mie Ayam', amount: 80000, date: '2024-05-05'),
  Payment(title: 'Chicken Burger', amount: 100000, date: '2024-05-07'),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentHistoryPage(),
    );
  }
}

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView.builder(
        itemCount: payments.length + 1, // Add 1 for the header
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Riwayat Pembelian',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          final payment = payments[index - 1];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(payment.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rp ${payment.amount.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    payment.date,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Add navigation to payment detail page
              },
            ),
          );
        },
      ),
    );
  }
}
