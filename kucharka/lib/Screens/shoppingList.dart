import 'package:flutter/material.dart';
import 'package:kucharka/Components/Drawer.dart';

class ShoppingListScreen extends StatefulWidget {
  final int selectedPage;

  ShoppingListScreen(this.selectedPage);

  @override
  ShoppingListScreenState createState() => ShoppingListScreenState();
}

class ShoppingListScreenState extends State<ShoppingListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /*leading:
        new Builder(builder: (context) {
          return IconButton(
            tooltip: 'Otevřít boční menu',
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              color: Colors.white,
              progress: recipesSearchDelegate.transitionAnimation,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();//scaffoldKey.currentState.openDrawer();
            },
          );
        }),*/
          title: Text('Nákupní seznam'),
          actions: <Widget>[],
        ),
        drawer: RecipesDrawer(widget.selectedPage),
        body: Center(child: Text('nakupní list')),
        //floatingActionButton: selectedFragment.getFab(),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        //bottomNavigationBar: botNavBar//selectedFragment.getBottonNavigatioBar(), //getBottomNavigationBar
      // (selectedFragmentIndex),
    );
  }
}
