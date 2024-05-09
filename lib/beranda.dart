import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_uts/riwayat_pembelian.dart';
import 'package:project_uts/main.dart';
import 'package:project_uts/profil.dart';
import 'package:project_uts/pencarian.dart';
import 'package:project_uts/keranjang.dart';

class MenuItem {
  final String name;
  final String description;
  final int price; // Mengubah tipe data harga menjadi int
  final String imagePath; // Menambahkan properti imagePath untuk gambar

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardHeader(), // Kembalikan CardHeader
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.0),
                    Card(
                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 12 / 5,
                            autoPlay: true,
                            autoPlayInterval: Duration(
                                seconds: 5), // Atur interval pergeseran gambar
                            autoPlayAnimationDuration: Duration(
                                milliseconds:
                                    800), // Atur durasi animasi pergeseran
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
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                    SizedBox(height: 20.0),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    NearbyRestaurantList(), // Tambahkan widget NearbyRestaurantList
                  ],
                ),
              ),
            ),
          ),
          CardMenu(), // Menu yang tidak ikut di-scroll
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
              width: 100.0, // Perbesar ukuran gambar
              height: 100.0, // Perbesar ukuran gambar
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 5.0),
                      Text(
                        '$rating',
                        style: TextStyle(
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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              'UDB FOODS',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Buka halaman keranjang belanja
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
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
                // Action when homepage card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Column(
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
                // Action when foodpage card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.search,
                    size: 35.0,
                  ),
                  Text('Pencarian'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Action when historypage card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentHistoryPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 35.0,
                  ),
                  Text('Riwayat Pembelian'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Action when profilepage card is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              child: Column(
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

class NearbyRestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Buat daftar menu makanan untuk setiap restoran
    List<MenuItem> nasiAyamMenu = [
      MenuItem(
        name: 'Nasi Ayam Bakar',
        description: 'Nasi ayam dengan ayam bakar dan sambal',
        price: 10000, // Harga dalam Rupiah
        imagePath:
            'asset_media/image/nasi_ayam_bakar.jpg', // Tambahkan imagePath
      ),
      MenuItem(
        name: 'Nasi Ayam Goreng',
        description: 'Nasi ayam dengan ayam goreng dan sambal',
        price: 9000, // Harga dalam Rupiah
        imagePath: 'asset_media/image/nasi_ayam.jpg', // Tambahkan imagePath
      ),
      // Tambahkan menu lainnya sesuai kebutuhan
    ];

    List<MenuItem> burgerMenu = [
      MenuItem(
        name: 'Burger',
        description: 'Burger dengan daging sapi, keju, dan saus',
        price: 15000, // Harga dalam Rupiah
        imagePath: 'asset_media/image/burger_bar.jpg', // Tambahkan imagePath
      ),
      MenuItem(
        name: 'Cheeseburger',
        description: 'Burger dengan daging sapi, keju, dan saus tomat',
        price: 18000, // Harga dalam Rupiah
        imagePath: 'asset_media/image/cheseeburger.jpg', // Tambahkan imagePath
      ),
      // Tambahkan menu lainnya sesuai kebutuhan
    ];

    List<MenuItem> mieAyamMenu = [
      MenuItem(
        name: 'Mie Ayam Spesial',
        description: 'Mie ayam dengan topping telur, jamur, dan sayuran',
        price: 8000, // Harga dalam Rupiah
        imagePath:
            'asset_media/image/mie_ayam_spesial.jpg', // Tambahkan imagePath
      ),
      MenuItem(
        name: 'Mie Ayam Pangsit',
        description: 'Mie ayam dengan pangsit goreng dan kuah',
        price: 10000, // Harga dalam Rupiah
        imagePath:
            'asset_media/image/mie_ayam_pangsit.jpg', // Tambahkan imagePath
      ),
      // Tambahkan menu lainnya sesuai kebutuhan
    ];

    return Column(
      children: [
        NearbyRestaurantPage(
          name: 'Nasi Ayam',
          description: 'Berbagai macam olahan daging ayam.',
          rating: 4.5,
          imagePath: 'asset_media/image/nasi_ayam.jpg',
          menuItems: nasiAyamMenu, // Tambahkan menuItems untuk Nasi Ayam
        ),
        NearbyRestaurantPage(
          name: 'Burger',
          description: 'Berbagai macam olahan burger.',
          rating: 4.8,
          imagePath: 'asset_media/image/burger_bar.jpg',
          menuItems: burgerMenu, // Tambahkan menuItems untuk Burger
        ),
        NearbyRestaurantPage(
          name: 'Mie Ayam',
          description: 'Mie ayam khas Jawa Tengah',
          rating: 4.5,
          imagePath: 'asset_media/image/mie_ayam.jpg',
          menuItems: mieAyamMenu, // Tambahkan menuItems untuk Mie Ayam
        ),
      ],
    );
  }
}

class NearbyRestaurantPage extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItems; // Tambahkan properti menuItems

  NearbyRestaurantPage({
    required this.name,
    required this.description,
    required this.rating,
    required this.imagePath,
    required this.menuItems, // Inisialisasi properti menuItems
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action when nearby restaurants card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsPage(
              name: name,
              description: description,
              rating: rating,
              imagePath: imagePath,
              menuItems: menuItems, // Kirim menuItems ke halaman baru
            ),
          ),
        );
      },
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    color: Colors.black54,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '$rating',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
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
  }
}

class RestaurantDetailsPage extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItems; // Tambahkan properti menuItems

  RestaurantDetailsPage({
    required this.name,
    required this.description,
    required this.rating,
    required this.imagePath,
    required this.menuItems, // Inisialisasi properti menuItems
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              height: 300.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '$rating',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Menu:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Menampilkan daftar menu makanan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: menuItems.map((item) {
                      return ListTile(
                        title: Row(
                          children: [
                            Image.asset(
                              item.imagePath,
                              width: 50, // Lebar gambar menu
                              height: 50, // Tinggi gambar menu
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Text(item.name),
                          ],
                        ),
                        subtitle: Text(item.description),
                        trailing: Text(
                          'Rp ${item.price}', // Konversi harga ke Rupiah
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
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

void main() {
  runApp(MyApp());
}
