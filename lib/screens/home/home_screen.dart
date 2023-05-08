import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendita/models/product.dart';
import 'package:tiendita/models/purchase.dart';
import 'package:tiendita/screens/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const quantities = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return Scaffold(
      body: ListView(
        children: [
          Autocomplete<Product>(
            displayStringForOption: (appUser) => appUser.name,
            optionsBuilder: (TextEditingValue value) {
              if (value.text == '') {
                return const Iterable<Product>.empty();
              }
              return bloc.products.where((Product option) {
                return option.name
                    .toLowerCase()
                    .contains(value.text.toLowerCase());
              });
            },
            onSelected: (Product selection) {
              bloc.selectProduct(selection);
            },
            // fieldViewBuilder: (BuildContext context,
            //     TextEditingController controller,
            //     FocusNode focusNode,
            //     VoidCallback onFieldSubmitted) {
            //   // Here you can customize the field view for the Autocomplete widget
            //   // In this example, we pass the _textEditingController to the Autocomplete widget
            //   // productController = controller;
            //   return TextFormField(
            //     controller: controller,
            //   );
            // },
          ),
          DropdownButton<int>(
            value: bloc.quantity ?? 1,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (int? value) {
              // This is called when the user selects an item.
              bloc.selectQuantity(value ?? 1);
            },
            items: quantities.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Precio Unitario: \$${bloc.product?.price ?? 0}'),
          Text('Total: \$${(bloc.product?.price ?? 0) * (bloc.quantity ?? 1)}'),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                if (bloc.product == null) {
                  final snackBar =
                      SnackBar(content: Text('Debe seleccionar un producto'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                bloc.makePurchase();
              },
              child: Text('Registrar compra')),
          SizedBox(
            height: 30,
          ),
          ...bloc.purchases
              .map((purchase) => PurchaseRow(purchase: purchase))
              .toList(),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class PurchaseRow extends StatelessWidget {
  const PurchaseRow({Key? key, required this.purchase}) : super(key: key);
  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(purchase.product.name),
        Text(' - '),
        Text(purchase.dateTime?.toIso8601String() ?? ''),
        Text(' - '),
        Text('${purchase.quantity}'),
        Text(' - '),
        Text('\$${purchase.quantity * purchase.product.price}'),
      ],
    );
  }
}
