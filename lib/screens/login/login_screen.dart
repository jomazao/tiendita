import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendita/models/app_user.dart';
import 'package:tiendita/screens/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Autocomplete<AppUser>(
            displayStringForOption: (appUser) => appUser.name,
            optionsBuilder: (TextEditingValue value) {
              if (value.text == '') {
                return const Iterable<AppUser>.empty();
              }
              return bloc.users.where((AppUser option) {
                return option.name
                    .toLowerCase()
                    .contains(value.text.toLowerCase());
              });
            },
            onSelected: (AppUser selection) {
              bloc.selectUser(selection);
            },
          ),
          TextButton(
              onPressed: () {
                if (bloc.user == null) {
                  final snackBar =
                      SnackBar(content: Text('Seleccione un usuario'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                Navigator.pushNamed(context, '/home', arguments: bloc.user!);
              },
              child: Text('Entrar'))
        ]),
      ),
    );
  }
}
