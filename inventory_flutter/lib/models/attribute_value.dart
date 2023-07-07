import 'package:realm/realm.dart';

part 'attribute_value.g.dart';

@RealmModel(ObjectType.embeddedObject)
class $AttributeValue {
  late ObjectId attributeId;
  late RealmValue value;
}
