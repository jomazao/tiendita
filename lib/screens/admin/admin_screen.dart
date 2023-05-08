import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: () {}, child: Text('Inventario')),
          TextButton(onPressed: () {}, child: Text('Personas y pagos')),
        ],
      ),
    );
  }
}
