import 'package:flutter/cupertino.dart';

enum Complexity{
  Simple,
  Challenging,
  Hard
}

enum Affordability{
  Affordable,
  Pricey,
  Luxurious
}

class Meal{
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({@required this.affordability,@required this.complexity,@required this.title,@required this.id,@required this.categories,@required this.duration,@required this.imageUrl,@required this.ingredients,@required this.isGlutenFree,@required this.isLactoseFree,@required this.isVegan,@required this.steps,@required this.isVegetarian});

  String get getComplexity {
    if(this.complexity==Complexity.Challenging)
      return 'Challenging';
    else if(this.complexity==Complexity.Hard)
      return'Hard';
    else return 'Simple';
  }

  String get getAffortability{
    if(this.affordability == Affordability.Affordable)
      return 'Affortable';
    else if (this.affordability == Affordability.Luxurious)
      return 'Luxurious';
    else return 'Pricey';
  }

}