import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String name;
  final String shortDescription;
  final String description;
  final String quantity;
  final List<String> procedure;
  final DocumentReference reference;
  final String id;

  Recipe.fromMap(Map<String, dynamic> data, {this.reference})
      : assert(data['name'] != null),
        assert(data['shortDescription'] != null),
        assert(data['description'] != null),
        assert(data['quantity'] != null),
        assert(data['procedure'] != null),
        name = data['name'],
        shortDescription = data['shortDescription'],
        description = data['description'],
        quantity = data['quantity'],
        procedure = List.from(data['procedure']),
        id = reference.documentID;

  Recipe.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Recipe<$name>";
}
