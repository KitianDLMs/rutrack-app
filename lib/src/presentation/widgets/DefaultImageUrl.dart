import 'package:flutter/material.dart';

class DefaultImageUrl extends StatelessWidget {
  final String? url;
  final double width;

  DefaultImageUrl({this.url, required this.width});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return Image.asset(
        'assets/img/user.png', // imagen por defecto
        width: width,
        height: width,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      url!,
      width: width,
      height: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/img/user.png',
          width: width,
          height: width,
        );
      },
    );
  }
}