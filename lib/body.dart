// ignore_for_file: unused_local_variable, prefer_const_constructors, use_super_parameters, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants = [
    Restaurant(
      name: 'Nasi Ayam',
      cuisine: 'Indonesia',
      menu: [
        MenuItem(
          name: 'Nasi Ayam Goreng',
          price: 10000,
          image: 'asset_media/image/nasi_ayam.jpg',
        ),
        MenuItem(
          name: 'Nasi Ayam Kremes',
          price: 10000,
          image: 'asset_media/image/nasi_ayam_kremes.jpg',
        ),
        MenuItem(
          name: 'Nasi Ayam Geprek',
          price: 12000,
          image: 'asset_media/image/nasi_ayam_geprek.jpg',
        ),
        MenuItem(
          name: 'Nasi Ayam Penyet',
          price: 11000,
          image: 'asset_media/image/nasi_ayam_penyet.jpg',
        ),
        MenuItem(
          name: 'Nasi Ayam Penyet Sambal Ijo',
          price: 12000,
          image: 'asset_media/image/nasi_ayam_penyet_sambal_ijo.jpg',
        ),
      ],
      drinks: [
        MenuItem(
          name: 'Ice Tea',
          price: 3000,
          image: 'asset_media/image/es_teh.jpg',
        ),
        MenuItem(
          name: 'Ice Lemon Tea',
          price: 3500,
          image: 'asset_media/image/es_lemon_tea.jpg',
        ),
        MenuItem(
          name: 'Ice Lemonade',
          price: 4000,
          image: 'asset_media/image/es_jeruk.jpg',
        ),
      ],
    ),
    Restaurant(
      name: 'Nasi Langgi',
      cuisine: 'Indonesia',
      menu: [
        MenuItem(
          name: 'Nasi Uduk',
          price: 10000,
          image: 'asset_media/image/nasi_uduk.jpg',
        ),
        MenuItem(
          name: 'Nasi Kuning',
          price: 12000,
          image: 'asset_media/image/nasi_kuning.jpg',
        ),
        MenuItem(
          name: 'Nasi Langgi',
          price: 11000,
          image: 'asset_media/image/nasi_langgi.jpg',
        ),
        MenuItem(
          name: 'Nasi Rames',
          price: 11000,
          image: 'asset_media/image/nasi_rames.jpg',
        ),
      ],
      drinks: [
        MenuItem(
          name: 'Ice Tea',
          price: 3000,
          image: 'asset_media/image/es_teh.jpg',
        ),
        MenuItem(
          name: 'Ice Lemon Tea',
          price: 3500,
          image: 'asset_media/image/es_lemon_tea.jpg',
        ),
        MenuItem(
          name: 'Ice Lemonade',
          price: 4000,
          image: 'asset_media/image/es_jeruk.jpg',
        ),
        MenuItem(
          name: 'Milkshake',
          price: 5000,
          image: 'asset_media/image/milkshake.jpg',
        ),
      ],
    ),
  ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Restaurants'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const SearchBody(),
      ),
    );
  }
}

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  String _searchQuery = '';
  List<Restaurant> _restaurants = [];

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    var snapshot = await FirebaseFirestore.instance.collection('restaurants').get();
    setState(() {
      _restaurants = snapshot.docs.map((doc) => Restaurant.fromFirestore(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = _restaurants[index];
              if (_searchQuery.isNotEmpty &&
                  !restaurant.name.toLowerCase().contains(_searchQuery)) {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetailPage(
                        restaurant: restaurant,
                      ),
                    ),
                  );
                },
                child: RestaurantCard(
                  restaurant: restaurant,
                  onAddToCart: (item) {
                    setState(() {
                      // Handle cart logic if needed
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Restaurant {
  final String name;
  final String cuisine;
  final List<MenuItem> menu;
  final List<MenuItem> drinks;

  Restaurant({
    required this.name,
    required this.cuisine,
    required this.menu,
    required this.drinks,
  });

  factory Restaurant.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Restaurant(
      name: data['name'],
      cuisine: data['cuisine'],
      menu: _parseMenuList(data['menu']),
      drinks: _parseMenuList(data['drinks']),
    );
  }

  static List<MenuItem> _parseMenuList(List<dynamic> list) {
    return list.map((item) => MenuItem.fromMap(item)).toList();
  }
}

class MenuItem {
  final String name;
  final int price;
  final String image;
  int quantity;

  MenuItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: map['name'],
      price: map['price'],
      image: map['image'],
      quantity: map['quantity'] ?? 1,
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function(MenuItem) onAddToCart;

  const RestaurantCard({Key? key, required this.restaurant, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            'asset_media/image/${restaurant.name.toLowerCase().replaceAll(' ', '_')}.jpg',
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          ListTile(
            title: Text(restaurant.name),
            subtitle: Text(restaurant.cuisine),
          ),
        ],
      ),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Menu Makanan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildMenuList(restaurant.menu, context),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Minuman:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildMenuList(restaurant.drinks, context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(List<MenuItem> items, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Image.asset(
            item.image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name),
              Row(
                children: [
                  Text(
                    'Rp ${item.price.toString()}',
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      item.quantity++;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart: ${item.name}'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
