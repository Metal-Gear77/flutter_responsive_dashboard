import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns:  <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows:  <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class DataTableDemo extends StatefulWidget {
  const DataTableDemo({super.key});

  @override
  State<DataTableDemo> createState() => _DataTableDemoState();
}

class _RestorableDessertSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  /// Takes a list of [_Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<_Dessert> desserts) {
    final updatedSet = <int>{};
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (dessert.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

class _DataTableDemoState extends State<DataTableDemo> with RestorationMixin {
  final _RestorableDessertSelections _dessertSelections =
      _RestorableDessertSelections();
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage =
      RestorableInt(PaginatedDataTable.defaultRowsPerPage);
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
  _DessertDataSource? _dessertsDataSource;

  @override
  String get restorationId => 'data_table_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_dessertSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');
    registerForRestoration(_sortAscending, 'sort_ascending');
    registerForRestoration(_sortColumnIndex, 'sort_column_index');

    _dessertsDataSource ??= _DessertDataSource(context);
    switch (_sortColumnIndex.value) {
      case 0:
        _dessertsDataSource!._sort<String>((d) => d.name, _sortAscending.value);
        break;
      case 1:
        _dessertsDataSource!
            ._sort<num>((d) => d.calories, _sortAscending.value);
        break;
      case 2:
        _dessertsDataSource!._sort<num>((d) => d.fat, _sortAscending.value);
        break;
      case 3:
        _dessertsDataSource!._sort<num>((d) => d.carbs, _sortAscending.value);
        break;
      case 4:
        _dessertsDataSource!._sort<num>((d) => d.protein, _sortAscending.value);
        break;
      case 5:
        _dessertsDataSource!._sort<num>((d) => d.sodium, _sortAscending.value);
        break;
      case 6:
        _dessertsDataSource!._sort<num>((d) => d.calcium, _sortAscending.value);
        break;
      case 7:
        _dessertsDataSource!._sort<num>((d) => d.iron, _sortAscending.value);
        break;
    }
    _dessertsDataSource!.updateSelectedDesserts(_dessertSelections);
    _dessertsDataSource!.addListener(_updateSelectedDessertRowListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dessertsDataSource ??= _DessertDataSource(context);
    _dessertsDataSource!.addListener(_updateSelectedDessertRowListener);
  }

  void _updateSelectedDessertRowListener() {
    _dessertSelections.setDessertSelections(_dessertsDataSource!._desserts);
  }

  void _sort<T>(
    Comparable<T> Function(_Dessert d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource!._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    });
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    _sortColumnIndex.dispose();
    _sortAscending.dispose();
    _dessertsDataSource!.removeListener(_updateSelectedDessertRowListener);
    _dessertsDataSource!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("데이터 표"),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'data_table_list_view',
          padding: const EdgeInsets.all(16),
          children: [
            PaginatedDataTable(
              header: Text("영양"),
              rowsPerPage: _rowsPerPage.value,
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage.value = value!;
                });
              },
              initialFirstRowIndex: _rowIndex.value,
              onPageChanged: (rowIndex) {
                setState(() {
                  _rowIndex.value = rowIndex;
                });
              },
              sortColumnIndex: _sortColumnIndex.value,
              sortAscending: _sortAscending.value,
              onSelectAll: _dessertsDataSource!._selectAll,
              columns: [
                DataColumn(
                  label: Text("디저트(1인분)"),
                  onSort: (columnIndex, ascending) =>
                      _sort<String>((d) => d.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("칼로리(kcal)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.calories, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("지방(g)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.fat, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("탄수화물(g)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.carbs, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("단백질(g)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.protein, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("나트륨(mg)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.sodium, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("칼슘(%)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.calcium, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("철분(%)"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((d) => d.iron, columnIndex, ascending),
                ),
              ],
              source: _dessertsDataSource!,
            ),
          ],
        ),
      ),
    );
  }
}

class _Dessert {
  _Dessert(
    this.name,
    this.calories,
    this.fat,
    this.carbs,
    this.protein,
    this.sodium,
    this.calcium,
    this.iron,
  );

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;
  bool selected = false;
}

class _DessertDataSource extends DataTableSource {
  _DessertDataSource(this.context) {
    _desserts = <_Dessert>[
      _Dessert(
        "프로즌 요거트",
        159,
        6.0,
        24,
        4.0,
        87,
        14,
        1,
      ),
      _Dessert(
        "아이스크림 샌드위치",
        237,
        9.0,
        37,
        4.3,
        129,
        8,
        1,
      ),
      _Dessert(
        "에클레르",
        262,
        16.0,
        24,
        6.0,
        337,
        6,
        7,
      ),
      _Dessert(
        "컵케이크",
        305,
        3.7,
        67,
        4.3,
        413,
        3,
        8,
      ),
      _Dessert(
        "진저브레드",
        356,
        16.0,
        49,
        3.9,
        327,
        7,
        16,
      ),
      _Dessert(
        "젤리빈",
        375,
        0.0,
        94,
        0.0,
        50,
        0,
        0,
      ),
      _Dessert(
        "롤리팝",
        392,
        0.2,
        98,
        0.0,
        38,
        0,
        2,
      ),
      _Dessert(
       "벌집꿀",
        408,
        3.2,
        87,
        6.5,
        562,
        0,
        45,
      ),
      _Dessert(
        "도넛",
        452,
        25.0,
        51,
        4.9,
        326,
        2,
        22,
      ),
      _Dessert(
        "애플파이",
        518,
        26.0,
        65,
        7.0,
        54,
        12,
        6,
      ),
      _Dessert(
        "설탕이 든 프로즌 요거트",
        168,
        6.0,
        26,
        4.0,
        87,
        14,
        1,
      ),
      _Dessert("설탕이 든 아이스크림 샌드위치",
        246,
        9.0,
        39,
        4.3,
        129,
        8,
        1,
      ),
      _Dessert("설탕이 든 에클레르",
        271,
        16.0,
        26,
        6.0,
        337,
        6,
        7,
      ),
      _Dessert("설탕이 든 컵케이크",
        314,
        3.7,
        69,
        4.3,
        413,
        3,
        8,
      ),
      _Dessert("설탕이 든 진저브레드",
        345,
        16.0,
        51,
        3.9,
        327,
        7,
        16,
      ),
      _Dessert("설탕이 든 젤리빈",
        364,
        0.0,
        96,
        0.0,
        50,
        0,
        0,
      ),
      _Dessert("설탕이 든 롤리팝",
        401,
        0.2,
        100,
        0.0,
        38,
        0,
        2,
      ),
      _Dessert("설탕이 든 벌집꿀",
        417,
        3.2,
        89,
        6.5,
        562,
        0,
        45,
      ),
      _Dessert("설탕이 든 도넛",
        461,
        25.0,
        53,
        4.9,
        326,
        2,
        22,
      ),
      _Dessert("설탕이 든 애플파이",
        527,
        26.0,
        67,
        7.0,
        54,
        12,
        6,
      ),
      _Dessert("꿀이 든 프로즌 요거트",
        223,
        6.0,
        36,
        4.0,
        87,
        14,
        1,
      ),
      _Dessert("꿀이 든 아이스크림 샌드위치",
        301,
        9.0,
        49,
        4.3,
        129,
        8,
        1,
      ),
      _Dessert("꿀이 든 에클레르",
        326,
        16.0,
        36,
        6.0,
        337,
        6,
        7,
      ),
      _Dessert("꿀이 든 컵케이크",
        369,
        3.7,
        79,
        4.3,
        413,
        3,
        8,
      ),
      _Dessert("꿀이 든 진저브레드",
        420,
        16.0,
        61,
        3.9,
        327,
        7,
        16,
      ),
      _Dessert("꿀이 든 젤리빈",
        439,
        0.0,
        106,
        0.0,
        50,
        0,
        0,
      ),
      _Dessert("꿀이 든 롤리팝",
        456,
        0.2,
        110,
        0.0,
        38,
        0,
        2,
      ),
      _Dessert("꿀이 든 벌꿉질",
        472,
        3.2,
        99,
        6.5,
        562,
        0,
        45,
      ),
      _Dessert("꿀이 든 도넛",
        516,
        25.0,
        63,
        4.9,
        326,
        2,
        22,
      ),
      _Dessert("꿀이 든 애플파이",
        582,
        26.0,
        77,
        7.0,
        54,
        12,
        6,
      ),
    ];
  }

  final BuildContext context;
  late List<_Dessert> _desserts;

  void _sort<T>(Comparable<T> Function(_Dessert d) getField, bool ascending) {
    _desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  void updateSelectedDesserts(_RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < _desserts.length; i += 1) {
      var dessert = _desserts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final format = NumberFormat.decimalPercentPattern(
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final dessert = _desserts[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (value) {
        if (dessert.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(dessert.name)),
        DataCell(Text('${dessert.calories}')),
        DataCell(Text(dessert.fat.toStringAsFixed(1))),
        DataCell(Text('${dessert.carbs}')),
        DataCell(Text(dessert.protein.toStringAsFixed(1))),
        DataCell(Text('${dessert.sodium}')),
        DataCell(Text(format.format(dessert.calcium / 100))),
        DataCell(Text(format.format(dessert.iron / 100))),
      ],
    );
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool? checked) {
    for (final dessert in _desserts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = checked! ? _desserts.length : 0;
    notifyListeners();
  }
}
