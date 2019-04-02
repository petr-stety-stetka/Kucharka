import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kucharka/Screens/login.dart';
import 'package:kucharka/Screens/recipes.dart';
import 'package:kucharka/Screens/settings.dart';
import 'package:kucharka/Screens/shoppingList.dart';
import 'package:kucharka/app.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class RecipesDrawer extends StatefulWidget {
  final int selectedPage;
  final drawerPagesItems = [
    DrawerItem("Recepty", Icons.restaurant),
    DrawerItem("Nákupní seznam", Icons.list),
  ];
  final drawerScreensItems = [DrawerItem("Nastavení", Icons.settings), DrawerItem("O aplikaci", Icons.info)];

  RecipesDrawer(this.selectedPage);

  @override
  RecipesDrawerState createState() => RecipesDrawerState();
}

class RecipesDrawerState extends State<RecipesDrawer> with TickerProviderStateMixin {
  static final Animatable<Offset> drawerTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.fastOutSlowIn));

  bool showDrawerContents = true;
  AnimationController drawerAnimationController;
  Animation<double> drawerContentsOpacity;
  Animation<Offset> drawerAccountsPosition;
  var logged = false;

  onSelectFragment(int index) {
    if (index == widget.selectedPage) {
      Navigator.of(context).pop(); // close the drawer
      return;
    }

    Navigator.of(context).pop(); // close the drawer

    var page;
    switch (index) {
      case 0:
        page = RecipesScreen(index);
        break;
      case 1:
        page = ShoppingListScreen(index);
        break;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  onSelectScreen(int index) {
    Navigator.of(context).pop(); // close the drawer

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case 1:
        showDialog(
            context: context,
            builder: (context) {
              return AboutDialog(
                  applicationName: App.title,
                  applicationVersion: "Verze: 0.1",
                  applicationIcon: Image(
                    image: ExactAssetImage('assets/images/app_icon.png'),
                    width: 60.0,
                  ),
                  applicationLegalese: '© 2019 Petr Štětka',
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: RichText(
                            text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(style: Theme.of(context).textTheme.body2, text: 'Nejlepší aplikace pro vaření.')
                          ],
                        )))
                  ]);
            });
        break;
      default:
        return Text("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(drawerAnimationController),
      curve: Curves.fastOutSlowIn,
    );
    drawerAccountsPosition = drawerAnimationController.drive(drawerTween);
  }

  @override
  void dispose() {
    drawerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerPages = [];
    List<Widget> drawerScreens = [];

    for (var i = 0; i < widget.drawerPagesItems.length; i++) {
      var d = widget.drawerPagesItems[i];
      drawerPages.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == widget.selectedPage,
        onTap: () => onSelectFragment(i),
      ));
    }

    for (var i = 0; i < widget.drawerScreensItems.length; i++) {
      var d = widget.drawerScreensItems[i];
      drawerScreens.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        onTap: () => onSelectScreen(i),
      ));
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          !logged
              ? UserAccountsDrawerHeader(
                  accountName: Text('Nepřihlášen'),
                  accountEmail: Text('Chcete-li se přihlásit klikněte zde'),
                  currentAccountPicture: Material(
                      elevation: 12.0,
                      shape: CircleBorder(),
                      color: Colors.transparent,
                      child: SvgPicture.asset('assets/images/account_circle.svg')),
                  onDetailsPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              : UserAccountsDrawerHeader(
                  accountName: Text('Trevor Widget'),
                  accountEmail: Text('trevor.widget@example.com'),
                  currentAccountPicture: Material(
                      elevation: 12.0,
                      shape: CircleBorder(),
                      color: Colors.transparent,
                      child: SvgPicture.asset('assets/images/account_circle.svg')),
                  onDetailsPressed: () {
                    showDrawerContents = !showDrawerContents;
                    if (showDrawerContents)
                      drawerAnimationController.reverse();
                    else
                      drawerAnimationController.forward();
                  },
                ),
          Expanded(
            child: Stack(
              children: <Widget>[
                // The initial contents of the drawer.
                FadeTransition(
                    opacity: drawerContentsOpacity,
                    child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
                      Column(children: drawerPages),
                      Divider(height: 1),
                      Column(children: drawerScreens)
                    ])),
                // The drawer's "details" view.
                SlideTransition(
                  position: drawerAccountsPosition,
                  child: FadeTransition(
                    opacity: ReverseAnimation(drawerContentsOpacity),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Spravovat účet'),
                          onTap: null,
                        ),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text('Odhlásit se'),
                          onTap: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
