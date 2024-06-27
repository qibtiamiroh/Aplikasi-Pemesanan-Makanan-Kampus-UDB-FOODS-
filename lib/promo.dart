// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

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
      body: const Center(
        child: const Text('Ini adalah halaman Promo'),
      ),
    );
  }
}