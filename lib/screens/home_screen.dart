import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/screens/filter_screen.dart';
import '../widgets/side_drawer.dart';
import './category_screen.dart';
import './favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Meal> favouriteMeal;
  HomeScreen(this.favouriteMeal);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Map<String, Object>> _onSelectIcon;

  @override
  void initState() {
    _onSelectIcon = [
      {
        'page': CategoryScreen(),
        'title': 'Recepie App',
      },
      {
        'page': FavouriteScreen(widget.favouriteMeal),
        'title': 'Faourites',
      }
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_onSelectIcon[_selectedIndex]['title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt_rounded),
            onPressed: () =>
                Navigator.of(context).pushNamed(FilterScreen.routeName),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Faourites",
          )
        ],
      ),
      body: _onSelectIcon[_selectedIndex]['page'],
      drawer: SideDrawer(),
    );
  }
}
