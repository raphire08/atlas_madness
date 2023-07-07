import 'package:realm/realm.dart';

part 'product.g.dart';

@RealmModel()
class $Product {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late ObjectId sellerId;
  late String name;
  late String type;
  late String subType;
  late String subSubType;
  late List<ObjectId> templateIds;
}
