// ignore_for_file: prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;
  int quantity;

  Product(
      {required this.name,
      required this.price,
      required this.image,
      this.quantity = 1});
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Product> _products = [
    Product(
      name: 'Nasi Ayam Goreng',
      price: 10000,
      image: 'asset_media/image/nasi_ayam.jpg',
    ),
    Product(
      name: 'Mie Ayam',
      price: 8000,
      image: 'asset_media/image/mie_ayam.jpg',
    ),
    Product(
      name: 'Chicken Burger',
      price: 15000,
      image: 'asset_media/image/chicken_burger.jpg',
    ),
  ];
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _updateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Row(
              children: [
                Text('Rp ${product.price.toString()}'),
                const Spacer(),
                Text(product.quantity.toString()), // Tampilkan jumlah produk
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: Rp ${_totalAmount.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18.0),
              ),
              ElevatedButton(
                onPressed: () {
                  // Checkout
                  // Implementasi checkout
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTotalAmount() {
    double total = 0;
    for (var product in _products) {
      total += product.price * product.quantity;
    }
    setState(() {
      _totalAmount = total;
    });
  }
}
