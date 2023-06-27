import 'package:flutter_command/flutter_command.dart';
import 'package:inventory_flutter/models/staff.dart';
import 'package:inventory_flutter/repo/app_repo.dart';

class UserManager {
  AppRepo repo = AppRepo();

  late Command<String, Staff?> userCommand;

  UserManager() {
    userCommand =
        Command.createSync<String, Staff?>(getStaff, initialValue: null);
  }

  Staff? getStaff(String id) {
    return repo.getStaff(id);
  }
}
