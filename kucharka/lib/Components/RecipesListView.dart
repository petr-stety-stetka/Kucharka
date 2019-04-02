import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kucharka/Misc/PrefService.dart';
import 'package:kucharka/Model/recipe.dart';
import 'package:kucharka/Screens/recipeDetail.dart';

class RecipesListView {
  RecipesListView(
    String category,
    TickerProvider vsync,
  )   : category = category,
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final List<String> favorites = PrefService.getListString('favorites') ?? List<String>();
  final String category;
  final AnimationController controller;
  Animation<double> _animation;

  Widget list(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('recepty').where('category', isEqualTo: category).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return buildList(context, snapshot.data.documents);
      },
    );
  }

  FadeTransition transition(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('recepty').where('category', isEqualTo: category).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return buildList(context, snapshot.data.documents);
        },
      ),
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      padding: EdgeInsets.all(4.0),
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final recipe = Recipe.fromSnapshot(data);
    bool favorite = favorites.contains(recipe.id) ? true : false;

    return Stack(children: <Widget>[
      Positioned.fill(
          bottom: 0.0,
          child: GridTile(
              footer: GestureDetector(
                  onTap: () {
                    print('CLICK');
                    return Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe)));
                  },
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
                  print('CLICK');

                  return Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe)));
                },
              ))),
    ]);
  }
}
