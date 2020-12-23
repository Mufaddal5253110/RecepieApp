import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';

class MealsDetailScreen extends StatelessWidget {
  static const routName = '/meals-detail';
  final Function toogleFaourites;
  final Function isFaourites;
  MealsDetailScreen(this.toogleFaourites, this.isFaourites);
  
  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            dishImage(meal.imageUrl),
            listTitle(context, "INGREDIENTS"),
            listOfItems(
              context,
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(15),
                    ),
                    color: Theme.of(context).primaryColorDark,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            listTitle(context, 'STEPS'),
            listOfItems(
              context,
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.black,
                      child: Text("#${index + 1}"),
                    ),
                    title: Text(meal.steps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: isFaourites(meal)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_outline),
        onPressed: () => toogleFaourites(meal),
      ),
    );
  }

  Widget dishImage(String url) {
    return Image.network(
      url,
      fit: BoxFit.fill,
      width: double.infinity,
      height: 250,
      loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
        if (progress == null) return child;
        return Padding(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes
                  : null,
            ));
      },
    );
  }

  Widget listOfItems(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Theme.of(context).accentColor,
        ),
      ),
      height: 150,
      width: 300,
      child: child,
    );
  }

  Widget listTitle(BuildContext context, String headline) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        headline,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}
