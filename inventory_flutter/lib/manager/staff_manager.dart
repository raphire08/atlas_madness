import 'dart:async';
import 'dart:developer';

import 'package:flutter_command/flutter_command.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:inventory_flutter/repo/app_repo.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:realm/realm.dart';

class StaffManager {
  AppRepo repo = AppRepo();

  List<Store> _stores = [];
  List<Store> get stores => _stores;

  late Command<List<Staff>, bool> createStaffCommand;

  late Command<List<Staff>, PlutoGrid> viewStaffCommand;

  StreamSubscription<List<Staff>>? staffSubscription;

  StaffManager() {
    createStaffCommand = Command.createSync(createStaffs, initialValue: false);

    viewStaffCommand = Command.createSync(getStaffGrid,
        initialValue: const PlutoGrid(columns: [], rows: []));
  }

  List<Store> getStores(ObjectId sellerId) {
    _stores = repo.getStore(sellerId);
    return _stores;
  }

  bool createStaffs(List<Staff> staffs) {
    try {
      repo.createStaffs(staffs);
      return true;
    } catch (e) {
      log('error while creating staff, $e');
      return false;
    }
  }

  PlutoGrid getInitialView(ObjectId sellerId) {
    final staffs = repo.getAllStaffs(sellerId);
    PlutoGrid grid = getStaffGrid(staffs);
    return grid;
  }

  void subscribeToStaffs(ObjectId sellerId) {
    final stream = repo.getStaffStream(sellerId);
    staffSubscription = stream.listen(
      (event) {
        viewStaffCommand.execute(event);
      },
      onError: (e) => log('error from store view listener $e'),
    );
  }

  void cancelSubscription() {
    staffSubscription?.cancel();
  }

  PlutoGrid getStaffGrid(List<Staff> staffs) {
    List<PlutoColumn> columns = [];
    if (staffs.isNotEmpty) {
      final map = getStaffMap(staffs[0]);
      columns = getColumnsForStaff(map);
    }
    List<PlutoRow> rows = [];
    for (final staff in staffs) {
      final map = getStaffMap(staff);
      final row = getRowForStaff(map);
      rows.add(row);
    }
    return PlutoGrid(columns: columns, rows: rows);
  }

  Map<String, dynamic> getStaffMap(Staff staff) {
    int index = _stores.indexWhere((element) => element.id == staff.storeId);
    return {
      'First Name': staff.firstName,
      'Last Name': staff.lastName,
      'Gender': staff.gender,
      'Date Of Birth': staff.dob,
      'Email': staff.email,
      'Primary Contact': staff.primaryContact,
      'Secondary Contact': staff.secondaryContact,
      'Store Name': index != -1 ? _stores[index].name : null,
      'Address': () => staff.address,
    };
  }

  List<PlutoColumn> getColumnsForStaff(Map<String, dynamic> map) {
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

  PlutoRow getRowForStaff(Map<String, dynamic> map) {
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
