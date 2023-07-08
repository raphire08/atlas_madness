import 'package:inventory_flutter/models/address.dart';
import 'package:inventory_flutter/models/attribute.dart';
import 'package:inventory_flutter/models/attribute_value.dart';
import 'package:inventory_flutter/models/data.dart';
import 'package:inventory_flutter/models/product.dart';
import 'package:inventory_flutter/models/product_template.dart';
import 'package:inventory_flutter/models/seller.dart';
import 'package:inventory_flutter/models/staff.dart';
import 'package:inventory_flutter/models/store.dart';
import 'package:realm/realm.dart';

import 'option.dart';
import 'option_set.dart';

export 'address.dart';
export 'attribute.dart';
export 'attribute_value.dart';
export 'data.dart';
export 'option.dart';
export 'option_set.dart';
export 'product.dart';
export 'product_template.dart';
export 'seller.dart';
export 'staff.dart';
export 'store.dart';

List<SchemaObject> get schemas => [
      Address.schema,
      Attribute.schema,
      AttributeValue.schema,
      Data.schema,
      Option.schema,
      OptionSet.schema,
      Product.schema,
      ProductTemplate.schema,
      Seller.schema,
      Staff.schema,
      Store.schema,
      StoreProperties.schema
    ];
