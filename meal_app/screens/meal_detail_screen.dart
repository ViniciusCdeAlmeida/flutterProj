import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toogleFavorite;
  final Function isFav;

  MealDetailScreen(this.toogleFavorite, this.isFav);
  static const routeName = '/meal-detail';

  Widget buildSelectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainerScreen(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSelectionTitle(context, 'ingredients'),
            buildContainerScreen(
              ListView.builder(
                itemBuilder: (ctx, idx) => Card(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients[idx])),
                  color: Theme.of(context).accentColor,
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSelectionTitle(context, 'Steps'),
            buildContainerScreen(
              ListView.builder(
                itemBuilder: (ctx, idx) => ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${idx + 1}'),
                  ),
                  title: Text(selectedMeal.steps[idx]),
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toogleFavorite(mealId),
        child: Icon(isFav(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
