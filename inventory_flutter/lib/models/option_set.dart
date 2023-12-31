import 'package:realm/realm.dart';

import 'option.dart';

part 'option_set.g.dart';

@RealmModel()
class $OptionSet {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late ObjectId sellerId;
  @Indexed(RealmIndexType.fullText)
  late String name;
  late ObjectId? parentSetId;
  late bool active;
  late List<$Option> options;
}
