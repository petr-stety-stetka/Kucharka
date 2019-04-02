import 'package:flutter/material.dart';

SnackBar showFavoriteSnackBar(bool favorite, undoAction) {
  return SnackBar(
    content: favorite ? Text('Recept byl přidán mezi oblíbené.') : Text('Recept byl odebrán z oblíbených.'),
    action: SnackBarAction(
      label: 'Zpět',
      onPressed: undoAction
    ),
  );
}