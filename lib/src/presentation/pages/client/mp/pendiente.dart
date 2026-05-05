import 'package:flutter/material.dart';

class PendientePage extends StatelessWidget {
  static const String routename ='client/mp/pendiente';
  const PendientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('pendiente'),
      ),
    );
  }
}