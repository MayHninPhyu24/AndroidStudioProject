import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious
}
class Meal {
  final String id;
  final List<String> categories;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  const Meal({
    required this.id,
    required this.categories,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree
  });

}
