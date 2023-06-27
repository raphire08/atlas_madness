import 'package:flutter/material.dart';
import 'package:inventory_flutter/manager/user_manager.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.userId, {super.key});
  final String userId;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlutoMenuItem> getItems() {
    return [
      PlutoMenuItem(title: 'Store', children: [
        PlutoMenuItem(title: 'View Stores'),
        PlutoMenuItem(title: 'Modify Store'),
        PlutoMenuItem(title: 'Add Store'),
        PlutoMenuItem(title: 'Delete Store')
      ]),
      PlutoMenuItem(title: 'Staff', children: [
        PlutoMenuItem(title: 'View Staff'),
        PlutoMenuItem(title: 'Modify Staff'),
        PlutoMenuItem(title: 'Add Staff'),
        PlutoMenuItem(title: 'Delete Staff')
      ]),
      PlutoMenuItem(title: 'Inventory'),
      PlutoMenuItem(title: 'Product'),
      PlutoMenuItem(title: 'Billing')
    ];
  }

  late UserManager userManager = UserManager();

  @override
  void initState() {
    super.initState();
    userManager.getStaff(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: const Text('Welcome, '),
        ),
        PlutoMenuBar(
          menus: getItems(),
          mode: PlutoMenuBarMode.hover,
        ),
      ],
    );
  }
}
