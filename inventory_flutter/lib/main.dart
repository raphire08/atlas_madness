import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/auth_manager.dart';
import 'package:inventory_flutter/manager/home_manager.dart';
import 'package:inventory_flutter/screens/home_screen.dart';
import 'package:inventory_flutter/screens/login_screen.dart';
import 'package:inventory_flutter/screens/register_screen.dart';
import 'package:realm/realm.dart';

import 'manager/option_manager.dart';
import 'manager/staff_manager.dart';
import 'manager/store_manager.dart';
import 'manager/user_manager.dart';
import 'models/auth_model.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerManager();
  runApp(const InventoryApp());
}

void registerManager() {
  getIt.registerSingleton(App(AppConfiguration('application-0-knrzx')));
  getIt.registerSingleton<AuthManager>(AuthManager());
  getIt.registerLazySingleton<UserManager>(() => UserManager());
  getIt.registerLazySingleton<StoreManager>(() => StoreManager());
  getIt.registerLazySingleton<HomeManager>(() => HomeManager());
  getIt.registerLazySingleton<StaffManager>(() => StaffManager());
  getIt.registerLazySingleton<OptionManager>(() => OptionManager());
}

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const LoginScreen(AuthMode.login);
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (context, state) {
            return const LoginScreen(AuthMode.login);
          },
        ),
        GoRoute(
          path: 'register',
          builder: (context, state) {
            return const RegisterScreen(AuthMode.register);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return HomeScreen();
      },
    ),
  ],
);

class InventoryApp extends StatelessWidget {
  const InventoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Inventory',
      theme: FlexColorScheme.light(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
      ).toTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
