import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/auth_manager.dart';
import 'package:inventory_flutter/models/auth_model.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:realm/realm.dart';

final emailValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(),
    FormBuilderValidators.email(),
  ],
);

final requiredValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(),
  ],
);

final dateValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.dateString(),
  ],
);

final numericValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.numeric(),
  ],
);

class FormAttribute {
  FormAttribute({
    required this.name,
    required String label,
    this.inputType,
    this.validator,
    this.isRequired = false,
  }) : label = isRequired ? '$label *' : label;
  String name;
  String label;
  TextInputType? inputType;
  String? Function(String?)? validator;
  bool isRequired;
}

List<FormAttribute> getAttributesForSeller() {
  return [
    FormAttribute(
      name: 'name',
      label: 'Organization Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    FormAttribute(
      name: 'contact',
      label: 'Organization Contact',
      validator: requiredValidator,
      isRequired: true,
    ),
    FormAttribute(
      name: 'email',
      label: 'Email',
      validator: emailValidator,
      isRequired: true,
    ),
    FormAttribute(name: 'streetAddress1', label: 'Street Address 1'),
    FormAttribute(name: 'streetAddress2', label: 'Street Address 2'),
    FormAttribute(name: 'city', label: 'City'),
    FormAttribute(
      name: 'pincode',
      label: 'Pincode',
      validator: numericValidator,
    ),
    FormAttribute(name: 'district', label: 'District'),
    FormAttribute(name: 'state', label: 'State'),
    FormAttribute(name: 'country', label: 'Country'),
  ];
}

List<FormAttribute> getAttributesForPrimaryUser() {
  return [
    FormAttribute(
      name: 'firstName',
      label: 'First Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    FormAttribute(
      name: 'lastName',
      label: 'Last Name',
      validator: requiredValidator,
      isRequired: true,
    ),
    FormAttribute(name: 'gender', label: 'Gender'),
    FormAttribute(
      name: 'dateOfBirth',
      label: 'Date Of Birth',
      validator: dateValidator,
    ),
    FormAttribute(name: 'primaryContact', label: 'Primary Contact'),
    FormAttribute(name: 'secondaryContact', label: 'Secondary Contact'),
    FormAttribute(
      name: 'email',
      label: 'Email',
      validator: emailValidator,
      isRequired: true,
    ),
    FormAttribute(
      name: 'password',
      label: 'Password',
      validator: requiredValidator,
      isRequired: true,
    ),
    FormAttribute(name: 'streetAddress1', label: 'Street Address 1'),
    FormAttribute(name: 'streetAddress2', label: 'Street Address 2'),
    FormAttribute(name: 'city', label: 'City'),
    FormAttribute(
      name: 'pincode',
      label: 'Pincode',
      validator: numericValidator,
    ),
    FormAttribute(name: 'district', label: 'District'),
    FormAttribute(name: 'state', label: 'State'),
    FormAttribute(name: 'country', label: 'Country'),
  ];
}

class RegisterGate extends StatelessWidget with GetItMixin {
  RegisterGate({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> formKeySeller =
      GlobalKey<FormBuilderState>();

  final GlobalKey<FormBuilderState> formKeyUser = GlobalKey<FormBuilderState>();

  Seller? getSeller() {
    formKeySeller.currentState?.save();
    bool? validated = formKeySeller.currentState?.validate();
    if (validated ?? false) {
      Map<String, dynamic>? fields = formKeySeller.currentState?.fields;
      String? name = fields?['name'].value;
      String? contact = fields?['contact']?.value;
      String? email = fields?['email']?.value;
      Address address = getAddress(fields);
      if (name != null && contact != null && email != null) {
        ObjectId id = ObjectId();
        return Seller(id, name, contact, email, address: address);
      }
    }
    return null;
  }

  Staff? getPrimaryStaff(ObjectId sellerId) {
    formKeyUser.currentState?.save();
    bool? validated = formKeyUser.currentState?.validate();
    if (validated ?? false) {
      Map<String, dynamic>? fields = formKeyUser.currentState?.fields;
      String? firstName = fields?['firstName'].value;
      String? lastName = fields?['lastName']?.value;
      String? email = fields?['email']?.value;
      String? gender = fields?['gender']?.value;
      String? dob = fields?['dateOfBirth']?.value;
      String? primaryContact = fields?['primaryContact']?.value;
      String? secondaryContact = fields?['secondaryContact']?.value;
      Address address = getAddress(fields);
      if (firstName != null && lastName != null && email != null) {
        ObjectId id = ObjectId();
        return Staff(
          id,
          firstName,
          lastName,
          gender ?? '',
          dob ?? '',
          email,
          sellerId,
          address: address,
          primaryContact: primaryContact,
          secondaryContact: secondaryContact,
        );
      }
    }
    return null;
  }

  Address getAddress(Map<String, dynamic>? fields) {
    String? streetAddress1 = fields?['streetAddress1'].value;
    String? streetAddress2 = fields?['streetAddress2'].value;
    String? city = fields?['city'].value;
    int? pincode = int.tryParse(fields?['pincode'].value ?? '');
    String? district = fields?['district'].value;
    String? state = fields?['state'].value;
    String? country = fields?['country'].value;
    return Address(
      city ?? '',
      pincode ?? -1,
      district ?? '',
      state ?? '',
      country ?? '',
      streetAddress1: streetAddress1,
      streetAddress2: streetAddress2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = watchX((AuthManager x) => x.registerCommand.isExecuting);
    final error = watchX((AuthManager x) => x.registerCommand.errors);
    print(error);
    registerHandler((AuthManager x) => x.registerCommand,
        (context, newValue, cancel) async {
      if (newValue) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text('Go to home page'),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  child: const Text('Okay'))
            ],
          ),
        ).then((value) {
          context.pop();
        });
      }
    });
    final authManager = get<AuthManager>();
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FormBuilder(
                      key: formKeySeller,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Seller Details For Registration',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: getAttributesForSeller()
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
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
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FormBuilder(
                      key: formKeyUser,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Primary User Details',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: getAttributesForPrimaryUser()
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
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
                  ),
                ),
              ),
              Expanded(
                child: Column(
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
                          if (!isLoading) {
                            Seller? seller = getSeller();
                            if (seller != null) {
                              Staff? primaryUser = getPrimaryStaff(seller.id);
                              if (primaryUser != null) {
                                String? password = formKeyUser
                                    .currentState?.fields['password']?.value;
                                if (password != null) {
                                  RegisterModel model = RegisterModel(
                                      seller, primaryUser, password);
                                  authManager.registerCommand.execute(model);
                                }
                              }
                            }
                          }
                        },
                        child: isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Back To Login'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
