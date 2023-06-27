import 'package:inventory_flutter/models/barrel.dart';
import 'package:realm/realm.dart';

part 'staff.g.dart';

@RealmModel()
class $Staff {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String firstName;
  late String lastName;
  late String gender;
  late String dob;
  late String? primaryContact;
  late String? secondaryContact;
  late String email;
  late $Address? address;
  @Indexed()
  late ObjectId sellerId;
  @Indexed()
  late ObjectId? storeId;
}
