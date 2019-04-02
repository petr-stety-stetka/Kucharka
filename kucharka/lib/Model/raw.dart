import 'package:cloud_firestore/cloud_firestore.dart';

class Raw {
  final String name;
  final String unit;
  final int count;//TODO to float?
  //final DocumentReference id;
  final DocumentReference reference;

  Raw.fromMap(Map<String, dynamic> data, {this.reference})
      : assert(data['name'] != null),
        assert(data['unit'] != null),
        assert(data['count'] != null),
       // assert(data['id'] != null),
        name = data['name'],
        unit = data['unit'],
        count = data['count'];
        //id = data['id'];

  Raw.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Raw<$name>";
}
