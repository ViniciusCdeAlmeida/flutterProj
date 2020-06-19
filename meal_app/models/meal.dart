import 'package:flutter/material.dart';

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
  final List<String> catIds;
  final List<String> ingredients;
  final String title;
  final String imageUrl;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isLactoseFree;
  final bool isGlutenFree;
  final bool isVegetarian;
  final bool isVegan;

  const Meal({
    @required this.id,
    @required this.catIds,
    @required this.title,
    @required this.imageUrl,
    @required this.ingredients,
    @required this.complexity,
    @required this.duration,
    @required this.affordability,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isGlutenFree,
    @required this.isVegetarian,
    @required this.steps,
  });
}
