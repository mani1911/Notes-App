import 'package:learndart/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:learndart/services/auth/auth_exception.dart';
import 'package:learndart/services/auth/auth_service.dart';
import 'package:learndart/views/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential =
                      await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  final user = AuthService.firebase().currentUser;
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(
                    verifyEmailRoute,
                  );
                } on WeakPasswordAuthExcption catch (e) {
                  await showErrorDialog(
                    context,
                    'Weak Password',
                  );
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(
                    context,
                    'Email Already In Use',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'Email is Invalid',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'Registration Failed',
                  );
                }
              },
              child: const Text('Register')),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Already have an Account? Login Here'))
        ],
      ),
    );
  }
}
