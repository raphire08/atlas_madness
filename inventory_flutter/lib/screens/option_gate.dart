import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/option_manager.dart';
import 'package:inventory_flutter/models/option.dart';
import 'package:inventory_flutter/models/option_set.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:realm/realm.dart';

import 'form_helper.dart';

List<TextFieldAttribute> getAttributesForOptionSet() {
  return [
    TextFieldAttribute(
      name: 'name',
      label: 'Option Set Name',
      validator: requiredValidator,
      isRequired: true,
    ),
  ];
}

List<FormAttribute> getAttributesForOption() {
  return [
    TextFieldAttribute(
      name: 'name',
      label: 'Option Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(name: 'sortOrder', label: 'Sort Order'),
    BooleanAttribute(name: 'isActive', label: 'Is Active'),
  ];
}

class AddOption extends StatelessWidget with GetItMixin {
  AddOption(this.sellerId, {Key? key}) : super(key: key);

  final ObjectId sellerId;

  final GlobalKey<FormBuilderState> formKeyOptionSet =
      GlobalKey<FormBuilderState>();

  OptionSet? getOptionSet() {
    formKeyOptionSet.currentState?.save();
    bool? validated = formKeyOptionSet.currentState?.validate();
    if (validated ?? false) {
      Map<String, dynamic>? fields = formKeyOptionSet.currentState?.fields;
      String? name = fields?['name'].value;
      if (name != null) {
        ObjectId id = ObjectId();
        return OptionSet(id, sellerId, name, true);
      }
    }
    return null;
  }

  void refreshForm() {
    Map<String, dynamic>? fields = formKeyOptionSet.currentState?.fields;
    if (fields != null) {
      for (final key in fields.keys) {
        final field = fields[key] as FormBuilderFieldState;
        field.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    registerHandler((OptionManager x) => x.createOptionSetCommand,
        (context, newValue, cancel) async {
      if (newValue) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('New option set added'),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                    refreshForm();
                  },
                  child: const Text('Okay'))
            ],
          ),
        );
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: FormBuilder(
          key: formKeyOptionSet,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getAttributesForOptionSet()
                  .map(
                    (e) => SizedBox(
                      width: 300,
                      child: FormBuilderTextField(
                        name: e.name,
                        decoration: InputDecoration(
                          labelText: e.label,
                          border: const OutlineInputBorder(),
                        ),
                        validator: e.validator,
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final set = getOptionSet();
                    if (set != null) {
                      final manager = get<OptionManager>();
                      manager.createOptionSetCommand.execute([set]);
                    } else {
                      log('option set is null execute command');
                    }
                  },
                  child: const Text('Create Option Set'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewOption extends StatefulWidget with GetItStatefulWidgetMixin {
  ViewOption(this.sellerId, this.setName, {Key? key}) : super(key: key);

  final String? setName;
  final ObjectId sellerId;

  @override
  State<ViewOption> createState() => _ViewOptionState();
}

class _ViewOptionState extends State<ViewOption> with GetItStateMixin {
  final _searchFieldKey = GlobalKey<FormBuilderFieldState>();
  late OptionManager optionManager;
  OptionSet? selectedSet;

  void onResultSelect(OptionSet optionSet) {
    selectedSet = optionSet;
    optionManager.setExecutionCommand.execute(false);
    _searchFieldKey.currentState?.reset();
    optionManager.viewOptionCommand.execute(optionSet.options);
    optionManager.setExecutionCommand.execute(true);
  }

  void onAddButtonPress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Material(
          child: SizedBox(
            width: 500,
            child: ModifyOption(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    optionManager = get<OptionManager>();
    optionManager.sellerId = widget.sellerId;
    optionManager.searchOptionSetCommand.value = [];
  }

  @override
  Widget build(BuildContext context) {
    List<OptionSet> searchResults =
        watchX((OptionManager manager) => manager.searchOptionSetCommand);
    bool executingSearch = watchX(
        (OptionManager manager) => manager.searchOptionSetCommand.isExecuting);
    PlutoGrid grid =
        watchX((OptionManager manager) => manager.viewOptionCommand);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  ...getAttributesForOptionSet()
                      .map(
                        (e) => SizedBox(
                          child: FormBuilderTextField(
                            key: _searchFieldKey,
                            name: e.name,
                            decoration: InputDecoration(
                              labelText: e.label,
                              border: const OutlineInputBorder(),
                            ),
                            validator: e.validator,
                            onChanged: optionManager.textChangedCommand,
                          ),
                        ),
                      )
                      .toList(),
                  if (searchResults.isNotEmpty || executingSearch)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Select Option',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                            ),
                            child: executingSearch
                                ? CircularProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  )
                                : ListView.builder(
                                    itemCount: searchResults.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          onResultSelect(searchResults[index]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child:
                                              Text(searchResults[index].name),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (selectedSet != null)
          grid.columns.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      'Options',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    grid,
                  ],
                )
              : Column(
                  children: [
                    const Text('No options exist'),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        onAddButtonPress(context);
                      },
                      child: const Text('Add Option'),
                    ),
                  ],
                )
      ],
    );
  }
}

class ModifyOption extends StatelessWidget {
  ModifyOption({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> formKeyOption =
      GlobalKey<FormBuilderState>();

  Option? getOption() {
    formKeyOption.currentState?.save();
    bool? validated = formKeyOption.currentState?.validate();
    if (validated ?? false) {
      Map<String, dynamic>? fields = formKeyOption.currentState?.fields;
      String? name = fields?['name'].value;
      int sortOrder = fields?['sortOrder'].value ?? 0;
      bool isActive = fields?['isActive'].value ?? true;
      if (name != null) {
        ObjectId objectId = ObjectId();
        return Option(objectId, name, -1, sortOrder, isActive);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FormBuilder(
        key: formKeyOption,
        child: Column(
          children: [
            ...getAttributesForOption()
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(e.label),
                        ),
                        const SizedBox(width: 20),
                        e is TextFieldAttribute
                            ? SizedBox(
                                width: 400,
                                child: FormBuilderTextField(
                                  name: e.name,
                                  decoration: InputDecoration(
                                    labelText: e.label,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: e.validator,
                                ),
                              )
                            : SizedBox(
                                width: 400,
                                child: FormBuilderCheckbox(
                                  name: e.name,
                                  title: Text(e.label),
                                ),
                              ),
                      ],
                    ),
                  ),
                )
                .toList(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Create Option'),
            ),
          ],
        ),
      ),
    );
  }
}
