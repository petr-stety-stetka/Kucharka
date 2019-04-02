import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kucharka/Misc/PrefService.dart';
import 'package:kucharka/Misc/kucharka_icons.dart';
import 'package:kucharka/Model/recipe.dart';
import 'package:kucharka/Screens/recipeDetail.dart';
import 'package:diacritic/diacritic.dart';

class RecipesSearchDelegate extends SearchDelegate {
  List<String> favorites = PrefService.getListString('favorites') ?? List<String>();

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query != '')
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showResults(context);
          },
        ),
      ];
    else
      return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return search();
  }

  Widget search() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('recepty').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        else
          return buildSearchResult(context, snapshot);
      },
    );
  }

  Widget buildSearchResult(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Recipe> searchRecipes = List<Recipe>();

    snapshot.data.documents.forEach((data) {
      final recipe = Recipe.fromSnapshot(data);

      final querySanitized = removeDiacritics(query.trim().toLowerCase());
      final nameSanitized = removeDiacritics(recipe.name.toLowerCase());
      final shortDescriptionSanitized = removeDiacritics(recipe.shortDescription.toLowerCase());
      final descriptionSanitized = removeDiacritics(recipe.description.toLowerCase());

      if (nameSanitized.contains(querySanitized) ||
          shortDescriptionSanitized.contains(querySanitized) ||
          descriptionSanitized.contains(querySanitized)) searchRecipes.add(recipe);
    });

    if (searchRecipes.length == 0)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Icon(
                Kucharka.emo_unhappy,
                size: 60,
              ),
            ),
            Text(
              "Bohužel žádný takový recept jsme nenašli. \n\nZkuste něco jiného.",
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    else
      return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        padding: EdgeInsets.all(4.0),
        children: searchRecipes.map((recipe) => _buildListItem(context, recipe)).toList(),
      );
  }

  void onTap(BuildContext context, recipe) {
    close(context, null);
    Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe)));
  }

  Widget _buildListItem(BuildContext context, Recipe recipe) {
    bool favorite = favorites.contains(recipe.id) ? true : false;
    return Stack(children: <Widget>[
      Positioned.fill(
          bottom: 0.0,
          child: GridTile(
              footer: GestureDetector(
                  onTap: () => onTap(context, recipe),
                  child: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: Text(recipe.name),
                    trailing: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                  )),
              child: new InkResponse(
                enableFeedback: true,
                child:
                    Hero(tag: recipe.id, child: Image.asset('assets/images/background_login.jpg', fit: BoxFit.cover)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe)));
                },
              ))),
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return search();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title.copyWith(
          color: Colors.white,
        )),
        inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.white)));
  }
}
