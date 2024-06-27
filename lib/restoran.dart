import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final int price;
  final String image;
  int quantity;

  MenuItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });
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
}

// Kelas RestaurantDetailPage
class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

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
      physics: const NeverScrollableScrollPhysics(),
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
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      item.quantity++;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to cart: ${item.name}'),
                          duration: const Duration(seconds: 1),
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

void main() {
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

  runApp(MaterialApp(
    title: 'Restaurant App',
    home: HomePage(restaurants: restaurants),
  ));
}

class HomePage extends StatelessWidget {
  final List<Restaurant> restaurants;

  const HomePage({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return ListTile(
            title: Text(restaurant.name),
            subtitle: Text(restaurant.cuisine),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(restaurant: restaurant),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
