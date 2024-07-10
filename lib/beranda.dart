import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_uts/keranjang.dart';
import 'package:project_uts/masuk.dart';
import 'package:project_uts/pencarian.dart';
import 'package:project_uts/profil.dart';
import 'package:project_uts/riwayat_pembelian.dart';

class MenuItem {
  final String name;
  final String description;
  final int price;
  final String imagePath;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _restaurantsRef =
      FirebaseFirestore.instance.collection('restaurants');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CardHeader(),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 200.0, // Adjust height as needed
                    child: Card(
                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 12 / 5,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                          ),
                          items: [
                            'asset_media/image/slide1.jpg',
                            'asset_media/image/slide2.jpg',
                            'asset_media/image/slide3.jpg',
                          ].map((imagePath) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Image.asset(
                                    imagePath,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Nearby Restaurants',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: _restaurantsRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No nearby restaurants found.');
                      }

                      return ListView.builder(
                        shrinkWrap: true, // Enable this to wrap content
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable scroll for the list
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;

                          // Handle null values
                          String name = data['name'] ?? 'Nasi Ayam';
                          String description = data['description'] ??
                              'Berbagai macam olahan daging ayam.';
                          double rating = (data['rating'] != null)
                              ? data['rating'].toDouble()
                              : 5.0;
                          String imagePath = data['imagePath'] ??
                              'asset_media/image/nasi_ayam.jpg';
                          List<MenuItem> menuItems =
                              (data['menuItems'] as List<dynamic>?)
                                      ?.map((item) {
                                    return MenuItem(
                                      name: item['name'] ?? 'Burger',
                                      description: item['description'] ??
                                          'Berbagai macam olahan burger',
                                      price: item['price'] ?? 0,
                                      imagePath: item['imagePath'] ??
                                          'asset_media/image/burger_bar.jpg',
                                    );
                                  }).toList() ??
                                  [];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailsPage(
                                    name: name,
                                    description: description,
                                    rating: rating,
                                    imagePath: imagePath,
                                    menuItems: menuItems,
                                  ),
                                ),
                              );
                            },
                            child: NearbyRestaurantPage(
                              name: name,
                              description: description,
                              rating: rating,
                              imagePath: imagePath,
                              menuItems: menuItems,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const CardMenu(),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(
      String imagePath, String name, String description, double rating) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5.0),
                      Text(
                        '$rating',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text(
              'UDB FOODS',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.home,
                    size: 35.0,
                  ),
                  Text('Beranda'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.search,
                    size: 35.0,
                  ),
                  Text('Cari'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentHistoryPage(),
                  ),
                );
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 35.0,
                  ),
                  Text('Riwayat'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 35.0,
                  ),
                  Text('Profil'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NearbyRestaurantPage extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItems;

  const NearbyRestaurantPage({
    super.key,
    required this.name,
    required this.description,
    required this.rating,
    required this.imagePath,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5.0),
                      Text(
                        '$rating',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantDetailsPage extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItems;

  const RestaurantDetailsPage({
    super.key,
    required this.name,
    required this.description,
    required this.rating,
    required this.imagePath,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10.0),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                const SizedBox(width: 5.0),
                Text(
                  '$rating',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Menu Items',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  var menuItem = menuItems[index];
                  return Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            menuItem.imagePath,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  menuItem.name,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  menuItem.description,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  'Price: \$${menuItem.price.toString()}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
