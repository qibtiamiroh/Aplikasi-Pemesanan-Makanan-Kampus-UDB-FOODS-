// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman profil.'),
      ),
    );
  }
}
