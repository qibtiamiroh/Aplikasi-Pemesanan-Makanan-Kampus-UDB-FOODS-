class Restaurant {
  final String id;
  final String name;
  final String address;
  final List<MenuItem> menu;

  Restaurant({required this.id, required this.name, required this.address, required this.menu});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var menuList = json['menu'] as List;
    List<MenuItem> menuItems = menuList.map((i) => MenuItem.fromJson(i)).toList();

    return Restaurant(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      menu: menuItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'menu': menu.map((i) => i.toJson()).toList(),
    };
  }
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
