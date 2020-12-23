import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filter_screen.dart';
import './screens/home_screen.dart';
import './screens/meals_detail_screen.dart';
import './screens/category_meal_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _initialeFilter = {
    "isGlutenFree": false,
    "isVegan": false,
    "isVegetarian": false,
    "isLactoseFree": false,
  };

  List<Meal> _avalaibleMeals = DUMMY_MEALS;
  List<Meal> _faouriteMeals = [];

  void _setFilteres(Map<String, bool> updatedFilter) {
    setState(() {
      _initialeFilter = updatedFilter;
      _avalaibleMeals = DUMMY_MEALS.where((meal) {
        if (!meal.isGlutenFree && _initialeFilter["isGlutenFree"]) {
          return false;
        }
        if (!meal.isLactoseFree && _initialeFilter["isLactoseFree"]) {
          return false;
        }
        if (!meal.isVegan && _initialeFilter["isVegan"]) {
          return false;
        }
        if (!meal.isVegetarian && _initialeFilter["isVegetarian"]) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isFaourite(Meal meal) {
    if (_faouriteMeals.contains(meal)) {
      return true;
    } else {
      return false;
    }
  }

  void _toggleFaourites(Meal meal) {
    setState(() {
      if (_faouriteMeals.contains(meal)) {
        _faouriteMeals.remove(meal);
      } else {
        _faouriteMeals.add(meal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final mq = MediaQuery.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        canvasColor: Colors.yellow.shade100,
        accentColor: Colors.yellowAccent,
        //fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                //fontFamily: 'RobotoCondensed',
                fontSize: 23,
              ),
            ),
      ),
      //home: CategoryScreen(),
      routes: {
        '/': (_) => HomeScreen(_faouriteMeals),
        CategoryMealScreen.routeName: (_) =>
            CategoryMealScreen(_avalaibleMeals),
        MealsDetailScreen.routName: (_) => MealsDetailScreen(_toggleFaourites,_isFaourite),
        FilterScreen.routeName: (_) =>
            FilterScreen(_setFilteres, _initialeFilter),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => HomeScreen(_faouriteMeals),
        );
      },
    );
  }
}
