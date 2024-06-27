// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_uts/admin/laporan_analitik.dart';
import 'package:project_uts/admin/manajemen_pengguna.dart';
import 'package:project_uts/admin/manajemen_pesanan.dart';
import 'package:project_uts/admin/manajemen_promosi.dart';
import 'package:project_uts/admin/manajemen_restoran.dart';
import 'package:project_uts/admin/manajemen_ulasan.dart';
import 'package:project_uts/admin/notifikasi.dart';
import 'package:project_uts/admin/pengaturan.dart';
import 'package:project_uts/admin/riwayat_transaksi.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Admin Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/logo.png'), // contoh penggunaan gambar/logo
                    radius: 30,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('User Management'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserManagementPage()));
            },
          ),
          ListTile(
            title: Text('Restaurant Management'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantManagementPage()));
            },
          ),
          ListTile(
            title: Text('Order Management'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderManagementPage()));
            },
          ),
          ListTile(
            title: Text('Promotion Management'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PromotionManagementPage()));
            },
          ),
          ListTile(
            title: Text('Reports and Analytics'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReportAnalyticsPage()));
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
            },
          ),
          ListTile(
            title: Text('Reviews and Ratings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewManagementPage()));
            },
          ),
          ListTile(
            title: Text('Payment Integration'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentIntegrationPage()));
            },
          ),
        ],
      ),
    );
  }
}