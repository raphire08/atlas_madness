import 'package:realm/realm.dart';

import 'attribute_value.dart';

part 'data.g.dart';

@RealmModel()
class $Data {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late ObjectId sellerId;
  late ObjectId productId;
  late DateTime createdOn;
  late DateTime modifiedOn;
  late List<$AttributeValue> values;
}
