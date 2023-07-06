import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/store_manager.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:realm/realm.dart';

import 'form_helper.dart';

List<TextFieldAttribute> getAttributesForStore() {
  return [
    TextFieldAttribute(
      name: 'storeName',
      label: 'Store Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'storeContact',
      label: 'Contact',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'storeEmail',
      label: 'Email',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(name: 'streetAddress1', label: 'Street Address 1'),
    TextFieldAttribute(name: 'streetAddress2', label: 'Street Address 2'),
    TextFieldAttribute(name: 'city', label: 'City'),
    TextFieldAttribute(
      name: 'pincode',
      label: 'Pincode',
      validator: numericValidator,
    ),
    TextFieldAttribute(name: 'district', label: 'District'),
    TextFieldAttribute(name: 'state', label: 'State'),
    TextFieldAttribute(name: 'country', label: 'Country'),
  ];
}

List<FormAttribute> getAttributesForStoreProperties() {
  return [
    BooleanAttribute(name: 'isPOS', label: 'Is Point of Sale?'),
    BooleanAttribute(name: 'isOnline', label: 'Is Online Store?'),
    BooleanAttribute(name: 'hasStorage', label: 'Store has Storage?'),
    BooleanAttribute(name: 'hasStaff', label: 'Store has Staff?'),
  ];
}

class StoreGate extends StatelessWidget {
  const StoreGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AddStore extends StatelessWidget with GetItMixin {
  AddStore(this.sellerId, {Key? key}) : super(key: key);

  final ObjectId sellerId;

  final GlobalKey<FormBuilderState> formKeyStore =
      GlobalKey<FormBuilderState>();

  StoreProperties getStoreProperties(Map<String, dynamic>? fields) {
    bool isPos = fields?['isPOS']?.value ?? false;
    bool isOnline = fields?['isOnline']?.value ?? false;
    bool hasStorage = fields?['hasStorage']?.value ?? false;
    bool hasStaff = fields?['hasStaff']?.value ?? false;
    return StoreProperties(
      isPOS: isPos,
      isOnline: isOnline,
      hasStorage: hasStorage,
      hasStaff: hasStaff,
    );
  }

  Store? getStore(ObjectId sellerId) {
    formKeyStore.currentState?.save();
    bool? validated = formKeyStore.currentState?.validate();
    if (validated ?? false) {
      Map<String, dynamic>? fields = formKeyStore.currentState?.fields;
      String? name = fields?['storeName'].value;
      String? contact = fields?['storeContact']?.value;
      String? email = fields?['storeEmail']?.value;
      Address address = getAddress(fields);
      StoreProperties properties = getStoreProperties(fields);
      if (name != null && contact != null && email != null) {
        ObjectId id = ObjectId();
        return Store(
          id,
          name,
          contact,
          email,
          sellerId,
          address: address,
          properties: properties,
        );
      }
    }
    return null;
  }

  void refreshForm() {
    Map<String, dynamic>? fields = formKeyStore.currentState?.fields;
    if (fields != null) {
      for (final key in fields.keys) {
        final field = fields[key] as FormBuilderFieldState;
        field.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final error = watchX((StoreManager x) => x.createStoreCommand.errors);
    registerHandler((StoreManager x) => x.createStoreCommand,
        (context, newValue, cancel) async {
      if (newValue) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('New store added'),
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
    final storeManager = get<StoreManager>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: formKeyStore,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Store Information',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: getAttributesForStore()
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: FormBuilderTextField(
                                  name: e.name,
                                  decoration: InputDecoration(
                                    labelText: e.label,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: e.validator,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Store Properties',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: getAttributesForStoreProperties().map((e) {
                        e as BooleanAttribute;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: FormBuilderCheckbox(
                            name: e.name,
                            title: Text(e.label),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: error != null,
                      child: Text(
                        'Something has gone wrong',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Store? store = getStore(sellerId);
                          if (store != null) {
                            storeManager.createStoreCommand.execute([store]);
                          } else {
                            log('cannot create store - null from form');
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewStore extends StatefulWidget with GetItStatefulWidgetMixin {
  ViewStore(this.sellerId, {Key? key}) : super(key: key);

  final ObjectId sellerId;

  @override
  State<ViewStore> createState() => _ViewStoreState();
}

class _ViewStoreState extends State<ViewStore> with GetItStateMixin {
  late StoreManager _storeManager;
  late PlutoGrid initialGrid;

  @override
  void initState() {
    super.initState();
    _storeManager = get<StoreManager>();
    initialGrid = _storeManager.getInitialView(widget.sellerId);
    _storeManager.subscribeToStores(widget.sellerId);
  }

  @override
  Widget build(BuildContext context) {
    final grid = watchX((StoreManager x) => x.viewStoreCommand);
    final error = watchX((StoreManager x) => x.viewStoreCommand.errors);
    if (error != null) {
      return const Center(child: Text('Something has gone wrong'));
    } else if (grid.columns.isNotEmpty) {
      return Center(child: grid);
    } else {
      return Center(child: initialGrid);
    }
  }
}
