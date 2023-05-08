import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tiendita/data/repositories/users_repository.dart';
import 'package:tiendita/models/app_user.dart';

enum LoginState {
  loading,
  loaded,
}

class LoginBloc extends ChangeNotifier {
  final _usersRepository = UsersRepository();
  LoginBloc() {
    init();
  }

  LoginState state = LoginState.loading;
  List<AppUser> users = [];
  AppUser? user;

  late StreamSubscription _usersSubscription;

  Future<void> init() async {
    users = await _usersRepository.usersStream().first;
    notifyListeners();
    _usersSubscription = _usersRepository.usersStream().listen((users) {
      this.users = users;
      notifyListeners();
    });
  }

  void selectUser(AppUser user) {
    this.user = user;
  }

  @override
  void dispose() {
    _usersSubscription.cancel();
    super.dispose();
  }
}
