import 'package:flutter/material.dart';
import 'package:inventory_flutter/models/auth_model.dart';
import 'package:inventory_flutter/screens/login_gate.dart';
import 'package:inventory_flutter/screens/register_gate.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen(this.authMode, {super.key});

  final AuthMode authMode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Atlas Madness',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    'Inventory Software',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: authMode == AuthMode.login ? LoginGate() : RegisterGate(),
          )
        ],
      ),
    );
  }
}
