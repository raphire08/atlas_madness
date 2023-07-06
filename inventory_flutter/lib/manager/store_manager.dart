import 'dart:async';
import 'dart:developer';

import 'package:flutter_command/flutter_command.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:inventory_flutter/repo/app_repo.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:realm/realm.dart';

class StoreManager {
  AppRepo repo = AppRepo();

  late Command<List<Store>, bool> createStoreCommand;

  late Command<List<Store>, PlutoGrid> viewStoreCommand;

  StreamSubscription<List<Store>>? storeSubscription;

  StoreManager() {
    createStoreCommand = Command.createSync(createStores, initialValue: false);

    viewStoreCommand = Command.createSync(getStoreGrid,
        initialValue: const PlutoGrid(columns: [], rows: []));
  }

  bool createStores(List<Store> stores) {
    try {
      repo.createStores(stores);
      return true;
    } catch (e) {
      log('error while creating store, $e');
      return false;
    }
  }

  PlutoGrid getInitialView(ObjectId sellerId) {
    final stores = repo.getStore(sellerId);
    PlutoGrid grid = getStoreGrid(stores);
    return grid;
  }

  void subscribeToStores(ObjectId sellerId) {
    final stream = repo.getStoreStream(sellerId);
    storeSubscription = stream.listen(
      (event) {
        viewStoreCommand.execute(event);
      },
      onError: (e) => log('error from store view listener $e'),
    );
  }

  void cancelSubscription() {
    storeSubscription?.cancel();
  }

  PlutoGrid getStoreGrid(List<Store> stores) {
    List<PlutoColumn> columns = [];
    if (stores.isNotEmpty) {
      final map = getStoreMap(stores[0]);
      columns = getColumnsForStore(map);
    }
    List<PlutoRow> rows = [];
    for (final store in stores) {
      final map = getStoreMap(store);
      final row = getRowForStore(map);
      rows.add(row);
    }
    return PlutoGrid(columns: columns, rows: rows);
  }

  Map<String, dynamic> getStoreMap(Store store) {
    return {
      'Name': store.name,
      'Contact': store.contact,
      'Email': store.email,
      'Is Pos': store.properties?.isPOS ?? false,
      'Is Online': store.properties?.isOnline ?? false,
      'Has Storage': store.properties?.hasStorage ?? false,
      'Has Staff': store.properties?.hasStaff ?? false,
      'Address': () => store.address,
    };
  }

  List<PlutoColumn> getColumnsForStore(Map<String, dynamic> map) {
    List<PlutoColumn> columns = [];
    for (final key in map.keys) {
      final plutoColumn = PlutoColumn(
        title: key,
        field: key,
        type: getType(map[key]),
        enableEditingMode: false,
      );
      columns.add(plutoColumn);
    }
    return columns;
  }

  PlutoRow getRowForStore(Map<String, dynamic> map) {
    Map<String, PlutoCell> cells =
        map.map((key, value) => MapEntry(key, PlutoCell(value: map[key])));
    return PlutoRow(cells: cells);
  }

  PlutoColumnType getType(dynamic value) {
    if (value is num) {
      return PlutoColumnType.number();
    } else if (value is DateTime) {
      return PlutoColumnType.date();
    } else {
      return PlutoColumnType.text();
    }
  }
}
