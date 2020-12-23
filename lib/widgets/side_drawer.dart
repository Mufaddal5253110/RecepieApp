import 'package:flutter/material.dart';
import 'package:food_app/screens/filter_screen.dart';

class SideDrawer extends StatelessWidget {
  void navigatingToFilterScreen(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(FilterScreen.routeName);
  }

  void navigatingToMeelScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/');
  }

  Widget drawerItems(IconData icon, String title, BuildContext context,
      Function navigatingHandler) {
    return ListTile(
      onTap: () => navigatingHandler(context),
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 150,
            color: Theme.of(context).primaryColorDark,
            child: Center(
              child: Text(
                "Let's Cook",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          drawerItems(
              Icons.restaurant_menu, "Meals", context, navigatingToMeelScreen),
          Divider(
            height: 5,
          ),
          drawerItems(
              Icons.filter_alt, "Filter", context, navigatingToFilterScreen),
          Divider(
            height: 5,
          ),
        ],
      ),
    );
  }
}
