import 'dart:developer';

import 'package:flutter_command/flutter_command.dart';
import 'package:inventory_flutter/models/option.dart';
import 'package:inventory_flutter/models/option_set.dart';
import 'package:inventory_flutter/repo/app_repo.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:realm/realm.dart';

class OptionManager {
  AppRepo repo = AppRepo();
  late Command<List<OptionSet>, bool> createOptionSetCommand;
  late Command<String, String> textChangedCommand;
  late Command<bool, bool> setExecutionCommand;
  late Command<String, List<OptionSet>> searchOptionSetCommand;
  late Command<List<Option>, PlutoGrid> viewOptionCommand;
  late Command<(OptionSet, Option), bool> addOptionCommand;

  ObjectId? sellerId;

  OptionManager() {
    createOptionSetCommand =
        Command.createSync(createSets, initialValue: false);

    setExecutionCommand =
        Command.createSync<bool, bool>((b) => b, initialValue: true);

    textChangedCommand = Command.createSync((s) => s,
        initialValue: '',
        restriction: setExecutionCommand.map((state) => !state));

    textChangedCommand.debounce(const Duration(milliseconds: 500)).listen(
          textChangeListener,
        );

    searchOptionSetCommand = Command.createAsync<String, List<OptionSet>>(
      searchOption, // Wrapped function
      initialValue: [], // Initial value
    );

    viewOptionCommand = Command.createSync(getOptionGrid,
        initialValue: const PlutoGrid(columns: [], rows: []));

    addOptionCommand =
        Command.createSync(addOptionInOptionSet, initialValue: false);
  }

  void textChangeListener(String filterText, _) {
    if (filterText.isNotEmpty) {
      searchOptionSetCommand.execute(filterText);
    } else {
      searchOptionSetCommand.value = [];
      searchOptionSetCommand.notifyListeners();
    }
  }

  bool createSets(List<OptionSet> sets) {
    try {
      repo.createDocuments<OptionSet>(sets);
      return true;
    } catch (e) {
      log('error while creating option set, $e');
      return false;
    }
  }

  Future<List<OptionSet>> searchOption(String text) async {
    if (sellerId != null) {
      return repo.searchOptionSet(sellerId!, text);
    } else {
      log('sellerId is null cannot search');
      throw Exception();
    }
  }

  PlutoGrid getOptionGrid(List<Option> options) {
    List<PlutoColumn> columns = [];
    if (options.isNotEmpty) {
      final map = getOptionMap(options[0]);
      columns = getColumnsForOption(map);
    }
    List<PlutoRow> rows = [];
    for (final option in options) {
      final map = getOptionMap(option);
      final row = getRowForOption(map);
      rows.add(row);
    }
    return PlutoGrid(columns: columns, rows: rows);
  }

  Map<String, dynamic> getOptionMap(Option option) {
    return {
      'Name': option.name,
      'Value': option.value,
      'Sort Order': option.sortOrder,
      'Active': option.active,
      'Parent Option Name': '',
    };
  }

  List<PlutoColumn> getColumnsForOption(Map<String, dynamic> map) {
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

  PlutoRow getRowForOption(Map<String, dynamic> map) {
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

  bool addOptionInOptionSet((OptionSet, Option) set) {
    final (optionSet, option) = set;
    repo.addOptionInSet(optionSet, option);
    return true;
  }

  void refreshOptionPage(ObjectId objectId) {
    final set = repo.getOptionSet(objectId);
    if (set != null) {
      viewOptionCommand.execute(set.options);
    }
  }
}
