import 'package:flutter/material.dart';
import 'package:inventory_flutter/models/auth_model.dart';
import 'package:inventory_flutter/screens/register_gate.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen(this.authMode, {Key? key}) : super(key: key);

  final AuthMode authMode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.maxFinite,
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Registration',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: RegisterGate(),
          )
        ],
      ),
    );
  }
}
