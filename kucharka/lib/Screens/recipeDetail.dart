import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kucharka/Components/FavoriteSnackBar.dart';
import 'package:kucharka/Components/MyPaginatedDataTable.dart';
import 'package:kucharka/Misc/PrefService.dart';
import 'package:kucharka/Model/RecipeDataSource.dart';
import 'package:kucharka/Model/recipe.dart';
import 'package:carousel_pro/carousel_pro.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailScreen(this.recipe);

  @override
  RecipeDetailScreenState createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends State<RecipeDetailScreen> {
  List<String> _favorites = PrefService.getListString('favorites') ?? List<String>();

  bool get favorite => _favorites.contains(widget.recipe.id);

  set favorite(bool val) {
    if (val)
      _favorites.add(widget.recipe.id);
    else
      _favorites.remove(widget.recipe.id);

    PrefService.setListString('favorites', _favorites);
  }

  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.recipe.name), actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return Row(children: <Widget>[
                IconButton(
                    icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        favorite = favorite ? false : true;
                        Scaffold.of(context).showSnackBar(showFavoriteSnackBar(favorite, () {
                          setState(() {
                            favorite = favorite ? false : true;
                          });
                        }));
                      });
                    }),
              ]);
            },
          )
        ]),
        body: ListView(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Hero(
                  tag: widget.recipe.id,
                  child: Carousel(
                    images: [
                      ExactAssetImage("assets/images/background_login.jpg"),
                      NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                      NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                      ExactAssetImage("assets/images/background_registration.jpg")
                    ],
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 450),
                    dotSize: 4.5,
                    dotSpacing: 16.0,
                    indicatorBgPadding: 12.0,
                    dotBgColor: Colors.transparent,
                    overlayShadow: true,
                    overlayShadowSize: 0.7,
                    autoplay: false,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(widget.recipe.shortDescription),
                            ),
                            subtitle: Text(widget.recipe.description),
                          ),
                        ),
                        ButtonTheme.bar(
                          // make buttons use the appropriate styles for cards
                          child: ButtonBar(
                            children: <Widget>[
                              /* TODO in next version FlatButton(
                                child: const Text('Přidat do ...'),
                                onPressed: () {},
                              ),*/
                              FlatButton(
                                child: const Text('Začít vařit'),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  getTable(widget.recipe.reference),
                ],
              ),
            )
          ],
        ));
  }

  getTable(DocumentReference reference) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('recepty').document(reference.documentID).collection('raws').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return buildTable(context, snapshot.data.documents);
      },
    );
  }

  buildTable(BuildContext context, List<DocumentSnapshot> raws) {
    int _rowsPerPage =
        raws.length < PaginatedDataTable.defaultRowsPerPage ? raws.length : PaginatedDataTable.defaultRowsPerPage;

    final RecipeDataSource recipeDataSource = RecipeDataSource(raws);

    return MyPaginatedDataTable(
        header: const Text('Suroviny'),
        rowsPerPage: _rowsPerPage,
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
          });
        },
        availableRowsPerPage: raws.length < PaginatedDataTable.defaultRowsPerPage
            ? [raws.length, raws.length * 2]
            : [PaginatedDataTable.defaultRowsPerPage ~/ 2, PaginatedDataTable.defaultRowsPerPage],
        columns: <DataColumn>[
          DataColumn(
            label: Text(widget.recipe.quantity),
          ),
          DataColumn(
            label: const Text('množství'),
            numeric: true,
          )
        ],
        source: recipeDataSource);
  }
}
