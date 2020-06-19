import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritiesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritiesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center( 
        child: Text('!!!!!!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            title: favoriteMeals[idx].title,
            id: favoriteMeals[idx].id,
            imageUrl: favoriteMeals[idx].imageUrl,
            affordability: favoriteMeals[idx].affordability,
            duration: favoriteMeals[idx].duration,
            complexity: favoriteMeals[idx].complexity,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
