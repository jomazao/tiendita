class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson({required String id, required Map json}) {
    return Product(
        id: id,
        name: json['name'],
        price: double.parse(json['price'].toString()));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
      };
}
