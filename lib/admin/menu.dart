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
      child: Column(
        children: [
          Container(
            color: Colors.blueAccent,
            padding: EdgeInsets.all(0),
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Admin Menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'asset_media/image/burger_bar.jpg'),
                      radius: 35, 
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.people, color: Colors.blue),
                    title: Text('Menejemen Pengguna'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserManagementPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.restaurant, color: Colors.blue),
                    title: Text('Menejemen Restoran'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantManagementPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list_alt, color: Colors.blue),
                    title: Text('Order Management'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderManagementPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.local_offer, color: Colors.blue),
                    title: Text('Menejemen Promosi'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PromotionManagementPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.analytics, color: Colors.blue),
                    title: Text('Ulasan dan Analisis'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportAnalyticsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.blue),
                    title: Text('Setting'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppSettingsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blue),
                    title: Text('Notifikasi'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.rate_review, color: Colors.blue),
                    title: Text('Menejemen Review'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewManagementPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history, color: Colors.blue),
                    title: Text('Riwayat Pembayaran'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentIntegrationPage()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
