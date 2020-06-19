import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = '/mealscreen';

  final List<Meal> avaliableMeals;

  CategoriesMealScreen(this.avaliableMeals);

  @override
  _CategoriesMealScreenState createState() => _CategoriesMealScreenState();
}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeal;
  bool _loadedData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final catId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeal = widget.avaliableMeals.where((meals) {
        return meals.catIds.contains(catId);
      }).toList();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeal.removeWhere((element) => element.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            title: displayedMeal[idx].title,
            id: displayedMeal[idx].id,
            imageUrl: displayedMeal[idx].imageUrl,
            affordability: displayedMeal[idx].affordability,
            duration: displayedMeal[idx].duration,
            complexity: displayedMeal[idx].complexity,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
