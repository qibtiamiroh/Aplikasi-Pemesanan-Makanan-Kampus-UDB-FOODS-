// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_uts/model/pengguna_model.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<User> users = [
    User(id: '1', name: 'John Doe', email: 'john@example.com', role: 'Mahasiswa'),
    User(id: '2', name: 'Jane Smith', email: 'jane@example.com', role: 'Dosen'),
  ];

  void addUser(User user) {
    setState(() {
      users.add(user);
    });
  }

  void updateUser(User user) {
    setState(() {
      final index = users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        users[index] = user;
      }
    });
  }

  void deleteUser(String id) {
    setState(() {
      users.removeWhere((user) => user.id == id);
    });
  }

  void showUserForm({User? user}) {
    final nameController = TextEditingController(text: user?.name ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    final roleController = TextEditingController(text: user?.role ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user == null ? 'Tambah Pengguna' : 'Ubah Pengguna'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(labelText: 'Peran'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (user == null) {
                  addUser(User(
                    id: DateTime.now().toString(),
                    name: nameController.text,
                    email: emailController.text,
                    role: roleController.text,
                  ));
                } else {
                  updateUser(User(
                    id: user.id,
                    name: nameController.text,
                    email: emailController.text,
                    role: roleController.text,
                  ));
                }
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Riwayat Pesanan dan Aktivitas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama: ${user.name}'),
              Text('Email: ${user.email}'),
              Text('Peran: ${user.role}'),
              // Tambahkan informasi riwayat pesanan dan aktivitas di sini
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Pengguna'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text('${user.email} - ${user.role}'),
            onTap: () => showUserDetails(user),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showUserForm(user: user),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteUser(user.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showUserForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
