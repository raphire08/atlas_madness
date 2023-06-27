import 'package:realm/realm.dart';

part 'address.g.dart';

@RealmModel(ObjectType.embeddedObject)
class $Address {
  late String? streetAddress1;
  late String? streetAddress2;
  late String city;
  late int pincode;
  late String district;
  late String state;
  late String country;
}
