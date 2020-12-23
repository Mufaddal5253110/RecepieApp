import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final Function setFilter;
  final Map<String, bool> currentFilters;
  static const routeName = '/filter-screen';

  FilterScreen(this.setFilter, this.currentFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isGlutenFree = false;
  var isVegan = false;
  var isVegetarian = false;
  var isLactoseFree = false;

  @override
  void initState() {
    isGlutenFree = widget.currentFilters["isGlutenFree"];
    isVegan = widget.currentFilters["isVegan"];
    isVegetarian = widget.currentFilters["isVegetarian"];
    isLactoseFree = widget.currentFilters["isLactoseFree"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> finalFilter = {
                "isGlutenFree": isGlutenFree,
                "isVegan": isVegan,
                "isVegetarian": isVegetarian,
                "isLactoseFree": isLactoseFree,
              };
              widget.setFilter(finalFilter);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildSwitches(
              "Gluten Free", "Only Include gluten free meals", isGlutenFree,
              (newVal) {
            setState(() {
              isGlutenFree = newVal;
            });
          }),
          _buildSwitches("Vegan", "Only Include vegan meals", isVegan,
              (newVal) {
            setState(() {
              isVegan = newVal;
            });
          }),
          _buildSwitches(
              "Vegetarian", "Only Include vegetarian meals", isVegetarian,
              (newVal) {
            setState(() {
              isVegetarian = newVal;
            });
          }),
          _buildSwitches(
              "Lactose Free", "Only Include lactose free meals", isLactoseFree,
              (newVal) {
            setState(() {
              isLactoseFree = newVal;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildSwitches(
      String title, String subtitile, bool val, Function onSwitching) {
    return SwitchListTile(
      onChanged: onSwitching,
      title: Text(title),
      value: val,
      subtitle: Text(subtitile),
    );
  }
}
