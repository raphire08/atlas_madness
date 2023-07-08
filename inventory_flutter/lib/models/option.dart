import 'package:realm/realm.dart';

part 'option.g.dart';

@RealmModel(ObjectType.embeddedObject)
class $Option {
  late ObjectId id;
  late String name;
  late int value;
  late int sortOrder;
  late bool active;
  late ObjectId? parentOptionId;
}
