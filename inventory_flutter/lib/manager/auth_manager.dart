import 'package:flutter_command/flutter_command.dart';
import 'package:inventory_flutter/models/auth_model.dart';
import 'package:inventory_flutter/repo/auth_repo.dart';

class AuthManager {
  AuthRepo repo = AuthRepo();

  late Command<AuthModel, AuthModel> loginCommand;

  late Command<RegisterModel, bool> registerCommand;

  AuthManager() {
    loginCommand = Command.createAsync<AuthModel, AuthModel>(login,
        initialValue: AuthModel.empty());

    registerCommand =
        Command.createAsync<RegisterModel, bool>(register, initialValue: false);
  }

  Future<AuthModel> login(AuthModel authModel) async {
    return await repo.login(authModel);
  }

  Future<bool> register(RegisterModel registerModel) async {
    return await repo.register(registerModel).then((value) => true);
  }
}
