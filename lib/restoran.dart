import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final String description;
  final double price;
  final String imagePath;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class RestaurantDetailPage extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItems;

  RestaurantDetailPage({
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  const SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5.0),
                      Text(
                        '$rating',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      MenuItem menuItem = menuItems[index];
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          leading: Image.asset(
                            menuItem.imagePath,
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                          title: Text(menuItem.name),
                          subtitle: Text(menuItem.description),
                          trailing:
                              Text('\$${menuItem.price.toStringAsFixed(2)}'),
                        ),
                      );
                    },
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

class NearbyRestaurantPage extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String imagePath;
  final List<MenuItem> menuItems;

  NearbyRestaurantPage({
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
      margin: const EdgeInsets.all(10.0),
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
