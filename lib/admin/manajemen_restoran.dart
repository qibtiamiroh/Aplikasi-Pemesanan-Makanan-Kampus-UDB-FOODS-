// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/model/restoran_model.dart';

class RestaurantManagementPage extends StatefulWidget {
  @override
  _RestaurantManagementPageState createState() =>
      _RestaurantManagementPageState();
}

class _RestaurantManagementPageState extends State<RestaurantManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addRestaurant(Restaurant restaurant) async {
    await _firestore.collection('restaurants').add(restaurant.toJson());
  }

  void updateRestaurant(Restaurant restaurant) async {
    await _firestore
        .collection('restaurants')
        .doc(restaurant.id)
        .update(restaurant.toJson());
  }

  void deleteRestaurant(String id) async {
    await _firestore.collection('restaurants').doc(id).delete();
  }

  void showRestaurantForm({Restaurant? restaurant}) {
    final nameController = TextEditingController(text: restaurant?.name ?? '');
    final addressController =
        TextEditingController(text: restaurant?.address ?? '');
    List<MenuItem> menu = restaurant?.menu ?? [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(restaurant == null ? 'Tambah Restoran' : 'Ubah Restoran'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Restoran'),
                ),
                TextField(
                  controller: addressController,
                  decoration:
                      const InputDecoration(labelText: 'Alamat Restoran'),
                ),
                const SizedBox(height: 10),
                const Text('Menu:'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menu.length,
                  itemBuilder: (context, index) {
                    final item = menu[index];
                    return ListTile(
                      title: Text('${item.name} - \$${item.price.toString()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            menu.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final itemNameController = TextEditingController();
                        final itemPriceController = TextEditingController();
                        return AlertDialog(
                          title: const Text('Tambah Item Menu'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: itemNameController,
                                decoration: const InputDecoration(
                                    labelText: 'Nama Item'),
                              ),
                              TextField(
                                controller: itemPriceController,
                                decoration: const InputDecoration(
                                    labelText: 'Harga Item'),
                                keyboardType: TextInputType.number,
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
                                setState(() {
                                  menu.add(MenuItem(
                                    name: itemNameController.text,
                                    price:
                                        double.parse(itemPriceController.text),
                                  ));
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Simpan'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Tambah Item Menu'),
                ),
              ],
            ),
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
                final newRestaurant = Restaurant(
                  id: restaurant?.id ?? DateTime.now().toString(),
                  name: nameController.text,
                  address: addressController.text,
                  menu: menu,
                );
                if (restaurant == null) {
                  addRestaurant(newRestaurant);
                } else {
                  updateRestaurant(newRestaurant);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Restoran'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('restaurants').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final restaurants = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Restaurant.fromJson({...data, 'id': doc.id});
          }).toList();

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return ListTile(
                title: Text(restaurant.name),
                subtitle: Text(restaurant.address),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          showRestaurantForm(restaurant: restaurant),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteRestaurant(restaurant.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showRestaurantForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
