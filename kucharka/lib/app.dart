import 'package:flutter/material.dart';
import 'package:kucharka/Screens/recipes.dart';

class App extends StatefulWidget {
  static const title = 'Kuchařka';

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return RecipesScreen(0);
  }
}