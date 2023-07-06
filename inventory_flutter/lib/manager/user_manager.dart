import 'dart:developer';

import 'package:flutter_command/flutter_command.dart';
import 'package:inventory_flutter/models/staff.dart';
import 'package:inventory_flutter/repo/app_repo.dart';

class UserManager {
  AppRepo repo = AppRepo();

  late Command<String, Staff?> userCommand;
  late Command<void, bool> refreshCommand;
  Staff? staff;

  UserManager() {
    userCommand =
        Command.createSync<String, Staff?>(getStaff, initialValue: null);
    refreshCommand =
        Command.createAsyncNoParam(refreshRealm, initialValue: false);
    refreshCommand.execute();
  }

  Staff? getStaff(String id) {
    staff = repo.getStaff(id);
    return staff;
  }

  Future<bool> refreshRealm() async {
    bool refreshed = await repo.refreshRealm();
    log('realm refresh status $refreshed');
    return refreshed;
  }
}
