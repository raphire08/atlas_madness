import 'package:inventory_flutter/models/address.dart';
import 'package:inventory_flutter/models/seller.dart';
import 'package:inventory_flutter/models/staff.dart';
import 'package:inventory_flutter/models/store.dart';
import 'package:realm/realm.dart';

export 'address.dart';
export 'seller.dart';
export 'staff.dart';
export 'store.dart';

List<SchemaObject> get schemas => [
      Address.schema,
      Seller.schema,
      Staff.schema,
      Store.schema,
    ];
