import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/auth_manager.dart';

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
    required this.label,
    this.inputType,
    this.validator,
  });
  String name;
  String label;
  TextInputType? inputType;
  String? Function(String?)? validator;
}

List<FormAttribute> getAttributesForSeller() {
  return [
    FormAttribute(
      name: 'name',
      label: 'Organization Name',
      validator: requiredValidator,
    ),
    FormAttribute(
      name: 'contact',
      label: 'Organization Contact',
      validator: requiredValidator,
    ),
    FormAttribute(
      name: 'email',
      label: 'Email',
      validator: emailValidator,
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
    ),
    FormAttribute(
      name: 'lastName',
      label: 'Last Name',
      validator: requiredValidator,
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
    ),
    FormAttribute(
      name: 'password',
      label: 'Password',
      validator: requiredValidator,
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
  @override
  Widget build(BuildContext context) {
    final isLoading = watchX((AuthManager x) => x.registerCommand.isExecuting);
    final error = watchX((AuthManager x) => x.registerCommand.errors);
    registerHandler((AuthManager x) => x.registerCommand,
        (context, newValue, cancel) async {
      if (newValue) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text('Please login'),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Okay'))
            ],
          ),
        ).then((value) {
          context.pop();
        });
      }
    });
    //final registered = watchX((AuthManager x) => x.registerCommand);
    final authManager = get<AuthManager>();
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FormBuilder(
                key: formKeySeller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: getAttributesForSeller()
                            .map((e) => FormBuilderTextField(
                                  name: e.name,
                                  decoration: InputDecoration(
                                    labelText: e.label,
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: e.validator,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
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
                          onPressed: () => isLoading
                              ? null
                              : authManager.registerCommand.execute(),
                          child: isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
