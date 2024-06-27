import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      AssetImage('asset_media/image/profile_image.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Ranty Maria',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '220103069',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              buildListItem(Icons.shopping_cart, 'Pesanan', () {}),
              buildListItem(Icons.notifications, 'Notifikasi', () {}),
              buildListItem(Icons.security, 'Keamanan Akun', () {}),
              buildListItem(Icons.settings, 'Atur Akun', () {}),
              buildListItem(Icons.edit, 'Edit Foto Profil', () {}),
              buildListItem(Icons.edit, 'Edit Nama Pengguna', () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
