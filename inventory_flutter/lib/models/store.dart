import 'package:inventory_flutter/models/barrel.dart';
import 'package:realm/realm.dart';

part 'store.g.dart';

@RealmModel()
class $Store {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;
  late $Address? address;
  late String contact;
  late String email;
  late $StoreProperties? properties;
  @Indexed()
  late ObjectId sellerId;
}

@RealmModel(ObjectType.embeddedObject)
class $StoreProperties {
  late bool isPOS = true;
  late bool isOnline = false;
  late bool hasStorage = true;
  late bool hasStaff = true;
  late bool hasGst = true;
  late String? gst;
}
