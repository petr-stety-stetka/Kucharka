import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kucharka/Model/raw.dart';

class RecipeDataSource extends DataTableSource {
  final List<Raw> raws;

  /* void _sort<T>(Comparable<T> getField(Dessert d), bool ascending) {
    _desserts.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }*/

 // int selectedCount = 0;

  RecipeDataSource._(this.raws);

  factory RecipeDataSource(List<DocumentSnapshot> snapshots) {
    List<Raw> raws = List<Raw>();

    snapshots.forEach((snapshot) => raws.add(Raw.fromSnapshot(snapshot)));

    return new RecipeDataSource._(raws);
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= raws.length) return null;
    final Raw raw = raws[index];
    return DataRow.byIndex(
        index: index,
       // selected: raw.selected,
        /*onSelectChanged: (bool value) {
          if (raw.selected != value) {
            selectedCount += value ? 1 : -1;
            assert(selectedCount >= 0);
            raw.selected = value;
            notifyListeners();
          }
        },*/
        onSelectChanged: null,
        cells: <DataCell>[
          DataCell(Text('${raw.name}')),
          DataCell(Text('${raw.count} ${raw.unit}')),
        ]);
  }

  @override
  int get rowCount => raws.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0; /*selectedCount;*/


/* void _selectAll(bool checked) {
    for (TestRaw raw in raws) raw.selected = checked;
    selectedCount = checked ? raws.length : 0;
    notifyListeners();
  }*/
}
