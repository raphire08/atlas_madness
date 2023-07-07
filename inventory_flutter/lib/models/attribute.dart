import 'package:realm/realm.dart';

part 'attribute.g.dart';

@RealmModel()
class $Attribute {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late ObjectId sellerId;
  late ObjectId productTemplateId;
  late String name;
  late int displayName;
  late String dataType;
  late ObjectId optionSetId;
  late bool isParent;
  late bool isChild;
  late bool isSelected;
}
