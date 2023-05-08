import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendita/models/app_user.dart';
import 'package:tiendita/models/product.dart';

class Purchase {
  final AppUser user;
  final int quantity;
  final Product product;
  DateTime? dateTime;

  Purchase({
    required this.user,
    required this.quantity,
    required this.product,
    this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'product': product.toJson(),
        'quantity': quantity,
        'dateTime': FieldValue.serverTimestamp(),
      };

  factory Purchase.fromJson({required Map json}) {
    return Purchase(
      user: AppUser.fromJson(json: json['user'], id: json['user']['id']),
      quantity: json['quantity'],
      product:
          Product.fromJson(json: json['product'], id: json['product']['id']),
      dateTime: json['dateTime'] == null
          ? null
          : (json['dateTime'] as Timestamp).toDate(),
    );
  }
}
