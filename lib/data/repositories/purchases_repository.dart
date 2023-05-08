import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiendita/models/purchase.dart';

class PurchasesRepository {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<Purchase>> purchasesStream({required String userId}) {
    return _firestore
        .collection('purchases')
        .where('user.id', isEqualTo: userId)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => Purchase.fromJson(json: doc.data()))
              .toList(),
        );
  }

  Future<void> purchaseProduct({required Purchase purchase}) async {
    _firestore.collection('purchases').add(purchase.toJson());
  }
}
