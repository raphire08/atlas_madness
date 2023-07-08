import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/staff_manager.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:realm/realm.dart';

import 'form_helper.dart';

List<TextFieldAttribute> getAttributesForStaff() {
  return [
    TextFieldAttribute(
      name: 'email',
      label: 'Email',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'password',
      label: 'Password',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'firstName',
      label: 'First Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'lastName',
      label: 'Last Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'gender',
      label: 'Gender',
      validator: requiredValidator,
      isRequired: true,
    ),
    TextFieldAttribute(
      name: 'dob',
      label: 'Date of Birth',
      validator: dateValidator,
    ),
    TextFieldAttribute(
      name: 'primaryContact',
      label: 'Primary Contact',
    ),
    TextFieldAttribute(
      name: 'secondaryContact',
      label: 'Secondary Contact',
    ),
  ];
}

List<TextFieldAttribute> getAttributesForAddress() {
  return [
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

class AddStaff extends StatefulWidget with GetItStatefulWidgetMixin {
  AddStaff(this.sellerId, {Key? key}) : super(key: key);

  final ObjectId sellerId;

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> with GetItStateMixin {
  final GlobalKey<FormBuilderState> formKeyStaff =
      GlobalKey<FormBuilderState>();

  final GlobalKey<FormBuilderState> formKeyAddress =
      GlobalKey<FormBuilderState>();

  List<Store> stores = [];

  String? selectedStoreName;

  late StaffManager staffManager;

  Staff? getStaff(ObjectId sellerId) {
    formKeyStaff.currentState?.save();
    bool? validated = formKeyStaff.currentState?.validate();
    if (validated ?? false) {
      Map<String, dynamic>? fields = formKeyStaff.currentState?.fields;
      String? email = fields?['email'].value;
      String? password = fields?['password']?.value;
      String? firstName = fields?['firstName']?.value;
      String? lastName = fields?['lastName']?.value;
      String? gender = fields?['gender']?.value;
      String? dob = fields?['dob']?.value;
      String? primaryContact = fields?['primaryContact']?.value;
      String? secondaryContact = fields?['primaryContact']?.value;
      formKeyAddress.currentState?.save();
      bool? addressValidated = formKeyStaff.currentState?.validate();
      Map<String, dynamic>? addFields;
      if (addressValidated ?? false) {
        addFields = formKeyAddress.currentState?.fields;
      }
      Address address = getAddress(addFields);
      if (email != null &&
          password != null &&
          firstName != null &&
          lastName != null &&
          gender != null) {
        ObjectId id = ObjectId();
        int index =
            stores.indexWhere((element) => element.name == selectedStoreName);
        ObjectId? storeId = index != -1 ? stores[index].id : null;
        return Staff(
          id,
          firstName,
          lastName,
          gender,
          dob ?? '',
          email,
          sellerId,
          storeId: storeId,
          primaryContact: primaryContact,
          secondaryContact: secondaryContact,
          address: address,
        );
      }
    }
    return null;
  }

  void refreshForm() {
    Map<String, dynamic>? fields = formKeyStaff.currentState?.fields;
    if (fields != null) {
      for (final key in fields.keys) {
        final field = fields[key] as FormBuilderFieldState;
        field.reset();
      }
    }
    Map<String, dynamic>? addFields = formKeyAddress.currentState?.fields;
    if (addFields != null) {
      for (final key in addFields.keys) {
        final field = addFields[key] as FormBuilderFieldState;
        field.reset();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    staffManager = get<StaffManager>();
    stores = staffManager.getStores(widget.sellerId);
  }

  @override
  Widget build(BuildContext context) {
    final error = watchX((StaffManager x) => x.createStaffCommand.errors);
    registerHandler((StaffManager x) => x.createStaffCommand,
        (context, newValue, cancel) async {
      if (newValue) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('New staff added'),
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilder(
              key: formKeyStaff,
              child: Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Staff Information',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ...getAttributesForStaff()
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
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
                        FormBuilderDropdown<String>(
                          name: 'store',
                          decoration: const InputDecoration(
                            labelText: 'Store',
                            border: OutlineInputBorder(),
                          ),
                          items: stores
                              .map<DropdownMenuItem<String>>(
                                (Store e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            selectedStoreName = value;
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 50),
            FormBuilder(
              key: formKeyAddress,
              child: Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Staff Address',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: getAttributesForAddress().map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: FormBuilderTextField(
                            name: e.name,
                            decoration: InputDecoration(
                              labelText: e.label,
                              border: const OutlineInputBorder(),
                            ),
                            validator: e.validator,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Staff? staff = getStaff(widget.sellerId);
                        if (staff != null) {
                          staffManager.createStaffCommand.execute([staff]);
                        } else {
                          log('cannot create staff - null from form');
                        }
                      },
                      child: const Text('Create Staff'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewStaff extends StatefulWidget with GetItStatefulWidgetMixin {
  ViewStaff(this.sellerId, {Key? key}) : super(key: key);

  final ObjectId sellerId;
  @override
  State<ViewStaff> createState() => _ViewStaffState();
}

class _ViewStaffState extends State<ViewStaff> with GetItStateMixin {
  late StaffManager _staffManager;
  late PlutoGrid initialGrid;

  @override
  void initState() {
    super.initState();
    _staffManager = get<StaffManager>();
    initialGrid = _staffManager.getInitialView(widget.sellerId);
    _staffManager.subscribeToStaffs(widget.sellerId);
  }

  @override
  Widget build(BuildContext context) {
    final grid = watchX((StaffManager x) => x.viewStaffCommand);
    final error = watchX((StaffManager x) => x.viewStaffCommand.errors);
    if (error != null) {
      return const Center(child: Text('Something has gone wrong'));
    } else if (grid.columns.isNotEmpty) {
      return Center(child: grid);
    } else {
      return Center(child: initialGrid);
    }
  }
}
