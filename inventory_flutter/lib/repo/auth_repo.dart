import 'dart:developer';
import 'dart:io';

import 'package:inventory_flutter/main.dart';
import 'package:inventory_flutter/models/auth_model.dart';
import 'package:inventory_flutter/models/barrel.dart';
import 'package:realm/realm.dart';

class AuthRepo {
  App app = getIt.get<App>();

  Future<AuthModel> login(AuthModel model) async {
    Credentials credentials =
        Credentials.emailPassword(model.email.toLowerCase(), model.password);
    return loginExistingUser(credentials, model);
  }

  Future<AuthModel> loginExistingUser(
    Credentials credentials,
    AuthModel model,
  ) async {
    try {
      User user = await app.logIn(credentials);
      configureRealm(user);
      model.isAuthenticated = true;
    } on RealmException catch (e) {
      model.isAuthenticated = false;
      model.authError = e.message;
    }
    return model;
  }

  Future<void> register(RegisterModel registerModel) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    bool register = false;
    try {
      await authProvider.registerUser(
          registerModel.staff.email, registerModel.password);
      register = true;
    } catch (e) {
      log(e.toString());
    }
    if (register) {
      AuthModel authModel = AuthModel.fromRegisterModel(registerModel);
      await login(authModel).then((value) {
        User? user = app.currentUser;
        if (user != null) {
          saveSeller(user, registerModel);
        }
      });
    }
  }

  void printConfigPath() {
    log(Configuration.defaultRealmPath);
  }

  void deleteRealm() {
    File file = File(Configuration.defaultRealmPath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  void saveSeller(User user, RegisterModel registerModel) {
    Realm realm = configureRealm(user);
    realm.write(() {
      registerModel.staff.id = ObjectId.fromHexString(user.id);
      realm.add<Seller>(registerModel.seller);
      realm.add<Staff>(registerModel.staff);
    });
  }

  Realm configureRealm(User user) {
    final config = Configuration.flexibleSync(user, schemas,
        clientResetHandler: const DiscardUnsyncedChangesHandler());
    Realm realm = Realm(config);
    log('configured synced realm');
    realm.subscriptions.update((mutableSubscriptions) {
      final staffQuery = realm.all<Staff>();
      final storeQuery = realm.all<Store>();
      final sellerQuery = realm.all<Seller>();
      mutableSubscriptions.add(staffQuery, name: "staff", update: true);
      mutableSubscriptions.add(storeQuery, name: "store", update: true);
      mutableSubscriptions.add(sellerQuery, name: "seller", update: true);
    });
    registerRealm(realm);
    return realm;
  }

  void registerRealm(Realm realm) {
    if (getIt.isRegistered<Realm>()) {
      getIt.unregister<Realm>();
    }
    getIt.registerSingleton<Realm>(realm);
    log('registered realm in get it');
  }

  User? getCurrentUser() {
    return app.currentUser;
  }
}
