import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  static const String routename ='client/mp/item';
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('item'),
      ),
    );
  }
}