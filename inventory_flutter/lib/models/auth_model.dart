import 'package:inventory_flutter/models/seller.dart';
import 'package:inventory_flutter/models/staff.dart';

/// The mode of the current auth session, either [AuthMode.login]
/// or [AuthMode.register].
enum AuthMode { login, register, link }

class AuthModel {
  String email;
  String password;
  bool isAuthenticated = false;
  String authError = '';
  AuthMode authMode = AuthMode.login;
  AuthModel(
    this.email,
    this.password,
  );

  AuthModel.empty()
      : email = '',
        password = '';
}

class RegisterModel {
  Seller seller;
  Staff staff;
  String password;
  RegisterModel(this.seller, this.staff, this.password);
}
