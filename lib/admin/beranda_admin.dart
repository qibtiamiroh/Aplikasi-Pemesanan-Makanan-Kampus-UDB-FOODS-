// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_uts/admin/menu.dart';
import 'package:project_uts/admin/notifikasi.dart';
import 'package:project_uts/admin/pengaturan.dart';
import 'package:project_uts/admin/profil.dart';
import 'package:project_uts/admin/riwayat_transaksi.dart';
import 'package:project_uts/admin/tentang.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AppSettingsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardMenuButton(
              icon: Icons.home,
              label: 'Beranda',
              onPressed: () {
                // Optional: Tidak perlu melakukan navigasi ke AdminHomePage karena sudah berada di sana.
              },
            ),
            CardMenuButton(
              icon: Icons.menu,
              label: 'Menu',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminMenu()),
                );
              },
            ),
            CardMenuButton(
              icon: Icons.history,
              label: 'Riwayat',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentIntegrationPage()),
                );
              },
            ),
            CardMenuButton(
              icon: Icons.info,
              label: 'Tentang',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const CardMenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
