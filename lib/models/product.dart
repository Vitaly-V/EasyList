import 'package:flutter/widgets.dart';

class Product {
  final String title;
  final String description;
  final String image;
  final double price;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product({
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.price,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite = false,
  });
}
