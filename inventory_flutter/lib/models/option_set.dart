import 'package:realm/realm.dart';

import 'option.dart';

part 'option_set.g.dart';

@RealmModel()
class $OptionSet {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late ObjectId sellerId;
  late String name;
  late int parentSetId;
  late bool active;
  late List<$Option> address;
}
