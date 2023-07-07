import 'package:realm/realm.dart';

part 'product_template.g.dart';

@RealmModel()
class $ProductTemplate {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late ObjectId sellerId;
  late String name;
  late String displayName;
  late String description;
}
