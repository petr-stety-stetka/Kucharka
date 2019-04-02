import 'package:flutter/material.dart';
import 'package:kucharka/Components/Drawer.dart';
import 'package:kucharka/Components/RecipesListView.dart';
import 'package:kucharka/Components/RecipesSearchDelegate.dart';
import 'package:kucharka/Misc/PrefService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kucharka/Misc/kucharka_icons.dart';
import 'package:kucharka/Model/recipe.dart';
import 'package:kucharka/Screens/login.dart';
import 'package:kucharka/Screens/recipeDetail.dart';
import 'package:kucharka/app.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipesScreen extends StatefulWidget {
  final int selectedPage;

  RecipesScreen(this.selectedPage);

  @override
  RecipesScreenState createState() => RecipesScreenState();
}

class RecipesScreenState extends State<RecipesScreen> with TickerProviderStateMixin {
  /* RecipesScreenState() {
    print("constructor...");
    eventBus.on<RefreshButtonPressed>().listen((event) {
      // All events are of type UserLoggedInEvent (or subtypes of it).
      print("Reloading...");
      setState(() {
        _isLoading = true;
      });
      //_fetchData();
    });

    //_fetchData();
  }*/

  var _isLoading = true;
  var bottomNavigationIndex = 0;
  List<RecipesListView> navigationViews;
  final List<Widget> transitions = <Widget>[];


  @override
  void initState() {
    super.initState();
     navigationViews = <RecipesListView>[
      RecipesListView('snack', this),
      RecipesListView('soup', this),
      RecipesListView('dinner', this),
      RecipesListView('dessert', this),
      RecipesListView('drink', this)
    ];

    for (RecipesListView view in navigationViews) transitions.add(view.list(context));


    navigationViews[bottomNavigationIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
      for (RecipesListView view in navigationViews) view.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipesSearchDelegate = RecipesSearchDelegate();



    return Scaffold(
      appBar: AppBar(
        leading:
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
        }),
        title: Text('Recepty'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: recipesSearchDelegate,
                  );
              }),
        ],
      ),
      drawer: RecipesDrawer(widget.selectedPage),
      body: buildTransitionsStack(bottomNavigationIndex),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cookieBite),
            activeIcon: Icon(FontAwesomeIcons.cookieBite),
            title: Text('Svačinky'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Kucharka.soup),
            activeIcon: Icon(Kucharka.soup),
            title: Text('Polévky'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Kucharka.dinner),
            activeIcon: Icon(Kucharka.dinner),
            title: Text('Jídlo'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Kucharka.pie),
            activeIcon: Icon(Kucharka.pie),
            title: Text('Zákusky'),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.glassMartiniAlt),
            activeIcon: Icon(FontAwesomeIcons.glassMartiniAlt),
            title: Text('Nápoje'),
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: bottomNavigationIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            navigationViews[bottomNavigationIndex].controller.reverse();
            bottomNavigationIndex = index;
            navigationViews[bottomNavigationIndex].controller.forward();
          });
        },
      ),
    );
  }

  Widget buildTransitionsStack(bottomNavigationIndex) {


    return transitions[bottomNavigationIndex];

/*
    // We want to have the newly animating (fading in) views on top.
   /* transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });*/

    //return transitions[bottomNavigationIndex];//Stack(children: transitions);
    var controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );

    return Stack(children: <Widget>[
    FadeTransition(opacity: controller.drive(CurveTween(curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn))), child: Center(child: Icon
      (Icons.add)))
    ]);


    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);*/
  }
}