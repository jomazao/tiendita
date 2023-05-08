import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tiendita/data/repositories/products_repository.dart';
import 'package:tiendita/data/repositories/purchases_repository.dart';
import 'package:tiendita/models/app_user.dart';
import 'package:tiendita/models/product.dart';
import 'package:tiendita/models/purchase.dart';

enum HomeState {
  loading,
  loaded,
}

class HomeBloc extends ChangeNotifier {
  final _productsRepository = ProductsRepository();
  final _purchasesRepository = PurchasesRepository();

  HomeBloc({required this.user}) {
    init();
  }

  HomeState state = HomeState.loading;
  List<Product> products = [];
  List<Purchase> purchases = [];
  final AppUser user;
  Product? product;
  int? quantity;

  late StreamSubscription<List<Product>> _productsSubscription;
  late StreamSubscription<List<Purchase>> _purchasesSubscription;

  Future<void> init() async {
    products = await _productsRepository.productsStream().first;
    notifyListeners();
    _productsSubscription =
        _productsRepository.productsStream().listen((products) {
      this.products = products;
      notifyListeners();
    });
    purchases =
        await _purchasesRepository.purchasesStream(userId: user.id).first;
    notifyListeners();
    _purchasesSubscription = _purchasesRepository
        .purchasesStream(userId: user.id)
        .listen((purchases) {
      this.purchases = purchases;
      notifyListeners();
    });
  }

  void selectProduct(Product product) {
    this.product = product;
    notifyListeners();
  }

  void selectQuantity(int quantity) {
    this.quantity = quantity;
    notifyListeners();
  }

  @override
  void dispose() {
    _productsSubscription.cancel();
    super.dispose();
  }

  Future<void> makePurchase() async {
    final purchase =
        Purchase(user: user, quantity: quantity ?? 1, product: product!);
    state = HomeState.loading;
    await _purchasesRepository.purchaseProduct(purchase: purchase);
    state = HomeState.loaded;
    product = null;
    quantity = null;
    notifyListeners();
  }
}
