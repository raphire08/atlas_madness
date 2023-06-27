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
  bool isPOS = true;
  bool isOnline = false;
  bool hasStorage = true;
  bool hasStaff = true;
  bool hasGst = true;
  String? gst;
}
