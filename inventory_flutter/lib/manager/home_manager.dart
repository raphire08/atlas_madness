import 'package:flutter_command/flutter_command.dart';

class HomeManager {
  late Command<String, String> getGateCommand;

  HomeManager() {
    getGateCommand = Command.createSync(getGate, initialValue: 'Add Store');
  }

  String getGate(String gateName) {
    return gateName;
  }
}
