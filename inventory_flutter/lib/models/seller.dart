import 'package:inventory_flutter/models/barrel.dart';
import 'package:realm/realm.dart';

part 'seller.g.dart';

@RealmModel()
class $Seller {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String name;
  late String contact;
  late String email;
  late $Address? address;
}
