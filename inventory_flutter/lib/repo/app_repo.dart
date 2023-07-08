import 'dart:developer';

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
    final primaryUser = realm.query<Staff>(
        '_id == \$0', [ObjectId.fromHexString('649ecddff36a7f286e3c3061')]);
    if (primaryUser.isNotEmpty) {
      return primaryUser[0];
    } else {
      return null;
    }
  }

  List<Staff> getAllStaffs(ObjectId sellerId) {
    return realm.query<Staff>('sellerId == \$0', [sellerId]).toList();
  }

  Future<bool> refreshRealm() async {
    try {
      return await realm.refreshAsync();
    } catch (e) {
      log('error while refreshing realm, $e');
      throw Exception();
    }
  }

  Stream<List<Store>> getStoreStream(ObjectId sellerId) {
    final stores = realm.query<Store>('sellerId == \$0', [sellerId]);
    return stores.changes.map((event) => event.results.toList());
  }

  List<Store> getStore(ObjectId sellerId) {
    return realm.query<Store>('sellerId == \$0', [sellerId]).toList();
  }

  Stream<List<Staff>> getStaffStream(ObjectId sellerId) {
    final staffs = realm.query<Staff>('sellerId == \$0', [sellerId]);
    return staffs.changes.map((event) => event.results.toList());
  }

  List<OptionSet> searchOptionSet(ObjectId sellerId, String text) {
    try {
      return realm.query<OptionSet>("sellerId == \$0 && name TEXT \$1 LIMIT(5)",
          [sellerId, text]).toList();
    } catch (e) {
      log('error while searching option set, $e');
      throw Exception();
    }
  }
}
