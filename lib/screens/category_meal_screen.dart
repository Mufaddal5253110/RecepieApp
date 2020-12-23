import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_items.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableCategories;

  CategoryMealScreen(this.availableCategories);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String title;
  var isInitialised = false;
  List<Meal> filteredCategories;

  @override
  void didChangeDependencies() {
    if (!isInitialised) {
      final arg =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      title = arg['title'];
      final id = arg['id'];
      filteredCategories = widget.availableCategories.where((element) {
        return element.categories.contains(id);
      }).toList();
      isInitialised = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 1,
        ),
        itemCount: filteredCategories.length,
        //physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return MealsItems(
            meal: filteredCategories[index],
          );
        },
      ),
    );
  }
}
