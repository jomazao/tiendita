import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendita/models/product.dart';

class ProductsRepository {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<Product>> productsStream() {
    return _firestore.collection('products').snapshots().map((event) => event
        .docs
        .map((doc) => Product.fromJson(id: doc.id, json: doc.data()))
        .toList());
  }

  final products = [
    {"name": "Bom bombum", "price": 400},
    {"name": "Cheese tris", "price": 2900},
    {"name": "Chocobreak choc blanco", "price": 250},
    {"name": "Chocobreak Relleno de bbb", "price": 200},
    {"name": "Chocodisk", "price": 750},
    {"name": "Chokis", "price": 1200},
    {"name": "Chokis bolita", "price": 1200},
    {"name": "Kick maní", "price": 1200},
    {"name": "Detodito 65 gr", "price": 3150},
    {"name": "Detodito 165gr", "price": 7150},
    {"name": "Doritos megaqueso 185gr", "price": 7350},
    {"name": "Doritos megaqueso 68gr", "price": 3150},
    {"name": "Galletas avena y granola", "price": 1000},
    {"name": "Galletas quaker", "price": 1000},
    {"name": "Galletas bridge", "price": 650},
    {"name": "Gaseosa postobón (manzana", "price": "colombiana"},
    {"name": "Gatorade", "price": 4300},
    {"name": "Gomitas Grissly", "price": 2000},
    {"name": "Gomas de colageno", "price": 2200},
    {"name": "Jugo hit 350 ml", "price": 2000},
    {"name": "Jugo hit 250 ml", "price": 1500},
    {"name": "Maní moto", "price": 1500},
    {"name": "Margarita 105 gr", "price": 5600},
    {"name": "Margarita 65gr", "price": 3100},
    {"name": "Margarita receta clasica 120 gr", "price": 5600},
    {"name": "Masmellos Millows", "price": 200},
    {"name": "Mordisqueta", "price": 350},
    {"name": "Natuchips 135 gr", "price": 6300},
    {"name": "Nucita crema", "price": 600},
    {"name": "Torta", "price": 2000},
    {"name": "Ponkys Vainilla", "price": 1200},
    {"name": "Ponkys", "price": 1150},
    {"name": "Powerade", "price": 3250},
    {"name": "Quimbaya bridge", "price": 550},
    {"name": "Cerveza Poker", "price": 2500},
    {"name": "Banano", "price": 600},
    {"name": "Mandarina", "price": 750},
    {"name": "Maracuya", "price": 1850},
    {"name": "Manzanas", "price": 2000},
    {"name": "Duraznos", "price": 1000}
  ];

  Future<void> insertProducts() async {
    var cont = 0;
    for (final product in products) {
      await _firestore.collection('products').add(product);
    }
  }
}
