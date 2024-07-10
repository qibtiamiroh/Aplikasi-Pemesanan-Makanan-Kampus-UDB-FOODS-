import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:project_uts/model/pengguna_model.dart';

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;
  fb_auth.User? _currentUser;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  void signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  void register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('Error registering: $e');
    }
  }

  void addUser(User user) async {
    await usersCollection.add({
      'name': user.name,
      'email': user.email,
      'role': user.role,
    });
  }

  void updateUser(User user) async {
    await usersCollection.doc(user.id).update({
      'name': user.name,
      'email': user.email,
      'role': user.role,
    });
  }

  void deleteUser(String id) async {
    await usersCollection.doc(id).delete();
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
        actions: [
          if (_currentUser != null)
            TextButton(
              onPressed: signOut,
              child: const Text('Logout'),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
        ],
      ),
      body: _currentUser == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final emailController = TextEditingController();
                          final passwordController = TextEditingController();
                          return AlertDialog(
                            title: const Text('Sign In'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: emailController,
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                ),
                                TextField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  obscureText: true,
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
                                  signIn(emailController.text,
                                      passwordController.text);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Login'),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final regEmailController =
                                          TextEditingController();
                                      final regPasswordController =
                                          TextEditingController();
                                      return AlertDialog(
                                        title: const Text('Register'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: regEmailController,
                                              decoration: const InputDecoration(
                                                  labelText: 'Email'),
                                            ),
                                            TextField(
                                              controller: regPasswordController,
                                              decoration: const InputDecoration(
                                                  labelText: 'Password'),
                                              obscureText: true,
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
                                              register(regEmailController.text,
                                                  regPasswordController.text);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Register'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Register'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: usersCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data?.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return User(
                        id: doc.id,
                        name:
                            data.containsKey('name') ? data['name'] : 'No Name',
                        email: data.containsKey('email')
                            ? data['email']
                            : 'No Email',
                        role:
                            data.containsKey('role') ? data['role'] : 'No Role',
                      );
                    }).toList() ??
                    [];

                return ListView.builder(
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
                );
              },
            ),
      floatingActionButton: _currentUser == null
          ? null
          : FloatingActionButton(
              onPressed: () => showUserForm(),
              child: const Icon(Icons.add),
            ),
    );
  }
}
