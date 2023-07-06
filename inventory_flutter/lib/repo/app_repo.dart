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

  RealmResults<Staff> getAllStaffs() {
    final result = realm.all<Staff>();
    log(result.length.toString());
    log(result.map((e) => e.id).toList().toString());
    return result;
  }

  Future<bool> refreshRealm() async {
    return await realm.refreshAsync();
  }

  Stream<List<Store>> getStoreStream(ObjectId sellerId) {
    final stores = realm.query<Store>('sellerId == \$0', [sellerId]);
    return stores.changes.map((event) => event.results.toList());
  }

  List<Store> getStore(ObjectId sellerId) {
    return realm.query<Store>('sellerId == \$0', [sellerId]).toList();
  }
}
