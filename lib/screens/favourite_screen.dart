import 'package:flutter/material.dart';

import '../widgets/meal_items.dart';
import '../models/meal.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouriteScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favourites yet - start adding some!'),
      );
    } else {
      return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 1,
        ),
        itemCount: favouriteMeals.length,
        //physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return MealsItems(
            meal: favouriteMeals[index],
          );
        },
      );
    }
  }
}
