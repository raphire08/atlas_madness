import 'package:inventory_flutter/main.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:realm/realm.dart';

class AppRepo {
  Realm realm = getIt.get<Realm>();

  void createDocuments<T extends RealmObject>(List<T> documents) {
    realm.write(() {
      realm.addAll<T>(documents);
    });
  }

  void createStores(List<Store> stores) {
    realm.write(() {
      realm.addAll<Store>(stores);
    });
  }

  void createStaffs(List<Staff> staffs) {
    realm.write(() {
      realm.addAll(staffs);
    });
  }

  Staff? getStaff(String id) {
    return realm.find<Staff>(id);
  }
}
