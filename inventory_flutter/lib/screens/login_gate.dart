import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_flutter/manager/auth_manager.dart';
import 'package:inventory_flutter/models/auth_model.dart';

class LoginGate extends StatelessWidget with GetItMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthMode mode = AuthMode.login;

  LoginGate({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = watchX((AuthManager x) => x.loginCommand.isExecuting);
    final AuthModel result = watchX((AuthManager x) => x.loginCommand);
    registerHandler((AuthManager x) => x.loginCommand,
        (context, newValue, cancel) async {
      if (newValue.isAuthenticated) {
        context.go('/home');
      }
    });
    print('authenticated: ${result.isAuthenticated}');
    final authManager = get<AuthManager>();
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Required',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: result.authError.isNotEmpty,
                        child: Text(
                          result.authError,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!isLoading) {
                              authManager.loginCommand.execute(
                                AuthModel(emailController.text,
                                    passwordController.text),
                              );
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : const Text('Login'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot password?'),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            const TextSpan(
                              text: "Don't have an account? ",
                            ),
                            TextSpan(
                              text: 'Register now',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/register');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
