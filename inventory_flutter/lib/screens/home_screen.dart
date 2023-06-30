import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:inventory_flutter/manager/user_manager.dart';
import 'package:inventory_flutter/repo/app_repo.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'package:realm/realm.dart';

import '../main.dart';
import '../models/barrel.dart';

class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with GetItStateMixin {
  List<PlutoMenuItem> getItems() {
    return [
      PlutoMenuItem(
        title: 'Store',
        onTap: () {
          AppRepo appRepo = AppRepo();
          appRepo.getAllStaffs();
        },
        children: [
          PlutoMenuItem(title: 'View Stores'),
          PlutoMenuItem(title: 'Modify Store'),
          PlutoMenuItem(title: 'Add Store'),
          PlutoMenuItem(title: 'Delete Store')
        ],
      ),
      PlutoMenuItem(
        title: 'Staff',
        onTap: () {},
        children: [
          PlutoMenuItem(title: 'View Staff'),
          PlutoMenuItem(title: 'Modify Staff'),
          PlutoMenuItem(title: 'Add Staff', onTap: () {}),
          PlutoMenuItem(title: 'Delete Staff')
        ],
      ),
      PlutoMenuItem(title: 'Inventory'),
      PlutoMenuItem(title: 'Product'),
      PlutoMenuItem(title: 'Billing')
    ];
  }

  UserManager userManager = UserManager();

  @override
  void initState() {
    super.initState();
  }

  String? getUserId() {
    App app = getIt.get<App>();
    return app.currentUser?.id;
  }

  @override
  Widget build(BuildContext context) {
    bool refreshComplete = watchX((UserManager x) => x.refreshCommand);
    registerHandler((UserManager x) => x.refreshCommand,
        (context, newValue, cancel) {
      if (newValue) {
        String? id = getUserId();
        if (id != null) {
          userManager.userCommand.execute(id);
        }
      }
    });
    if (refreshComplete) {
      return Material(
        child: Column(
          children: [
            ValueListenableBuilder<Staff?>(
              valueListenable: userManager.userCommand,
              builder: (context, value, child) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: value != null
                      ? Text('Welcome, ${value.firstName}')
                      : const Text('Welcome'),
                );
              },
            ),
            PlutoMenuBar(
              menus: getItems(),
              mode: PlutoMenuBarMode.hover,
            ),
          ],
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
