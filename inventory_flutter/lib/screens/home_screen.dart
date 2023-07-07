import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:inventory_flutter/manager/home_manager.dart';
import 'package:inventory_flutter/manager/user_manager.dart';
import 'package:inventory_flutter/screens/store_gate.dart';
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
  late UserManager userManager;
  late HomeManager homeManager;

  void handleMenuTap(String menuName) {
    homeManager.getGateCommand.execute(menuName);
  }

  List<PlutoMenuItem> getItems() {
    return [
      PlutoMenuItem(
        title: 'Store',
        children: [
          PlutoMenuItem(
              title: 'View Stores',
              onTap: () {
                homeManager.getGateCommand.execute('View Stores');
              }),
          PlutoMenuItem(
              title: 'Add Store',
              onTap: () {
                homeManager.getGateCommand.execute('Add Store');
              }),
        ],
      ),
      PlutoMenuItem(
        title: 'Staff',
        onTap: () {},
        children: [
          PlutoMenuItem(
              title: 'View Staff',
              onTap: () {
                homeManager.getGateCommand.execute('View Staff');
              }),
          PlutoMenuItem(
              title: 'Add Staff',
              onTap: () {
                homeManager.getGateCommand.execute('Add Staff');
              }),
        ],
      ),
      PlutoMenuItem(title: 'Inventory'),
      PlutoMenuItem(title: 'Product'),
      PlutoMenuItem(title: 'Billing')
    ];
  }

  @override
  void initState() {
    super.initState();
    userManager = get<UserManager>();
    homeManager = get<HomeManager>();
  }

  String? getUserId() {
    App app = getIt.get<App>();
    return app.currentUser?.id;
  }

  ObjectId? getSellerId() {
    return userManager.staff?.sellerId;
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
                String text =
                    value != null ? 'Welcome, ${value.firstName}' : 'Welcome';
                return Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 10),
                  height: 40,
                  color: Theme.of(context).primaryColor,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                );
              },
            ),
            PlutoMenuBar(
              menus: getItems(),
              mode: PlutoMenuBarMode.hover,
            ),
            Flexible(child: HomeBody(getSellerId())),
          ],
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class HomeBody extends StatelessWidget with GetItMixin {
  HomeBody(this.sellerId, {Key? key}) : super(key: key);
  final ObjectId? sellerId;
  @override
  Widget build(BuildContext context) {
    final name = watchX((HomeManager x) => x.getGateCommand);
    if (sellerId != null) {
      switch (name) {
        case 'Add Store':
          return AddStore(sellerId!);
        case 'View Stores':
          return ViewStore(sellerId!);
        default:
          return ViewStore(sellerId!);
      }
    } else {
      return const Center(
        child: Text('Error: Seller cannot be found'),
      );
    }
  }
}
