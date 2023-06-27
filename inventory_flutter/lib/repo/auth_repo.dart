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
    await authProvider.registerUser(
        registerModel.staff.email, registerModel.password);
    saveSeller(registerModel);
  }

  void saveSeller(RegisterModel registerModel) {
    final config = Configuration.disconnectedSync(schemas,
        path: Configuration.defaultRealmPath);
    Realm realm = Realm(config);
    realm.write(() {
      realm.add<Seller>(registerModel.seller);
      realm.add<Staff>(registerModel.staff);
    });
  }

  void configureRealm(User user) {
    final config = Configuration.flexibleSync(user, schemas);
    Realm realm = Realm(config);
    registerRealm(realm);
  }

  void registerRealm(Realm realm) {
    if (getIt.isRegistered<Realm>()) {
      getIt.unregister();
    }
    getIt.registerSingleton(realm);
  }
}
