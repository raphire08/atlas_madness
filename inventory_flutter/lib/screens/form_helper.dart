import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inventory_flutter/models/address.dart';

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

enum AttributeType {
  textField,
  bool,
}

abstract class FormAttribute {
  FormAttribute({required this.attributeType});
  AttributeType attributeType;
}

class TextFieldAttribute extends FormAttribute {
  TextFieldAttribute({
    required this.name,
    required String label,
    this.inputType,
    this.validator,
    this.isRequired = false,
    super.attributeType = AttributeType.textField,
  }) : label = isRequired ? '$label *' : label;
  String name;
  String label;
  TextInputType? inputType;
  String? Function(String?)? validator;
  bool isRequired;
}

class BooleanAttribute extends FormAttribute {
  BooleanAttribute({
    required this.name,
    required this.label,
    super.attributeType = AttributeType.bool,
  });

  String name;
  String label;
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
