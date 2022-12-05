import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learndart/constants/routes.dart';
import 'package:learndart/views/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(
        title: const Text('Login'),
      ),
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
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                  final currUser = FirebaseAuth.instance.currentUser;
                  if (currUser?.emailVerified ?? false) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute, (route) => false);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found" || e.code == "invalid-email") {
                    await showErrorDialog(
                      context,
                      'User Not Found',
                    );
                  } else if (e.code == "wrong-password") {
                    await showErrorDialog(
                      context,
                      'Wrong Password',
                    );
                  } else if (e.code == "network-request-failed") {
                    await showErrorDialog(
                      context,
                      'Check Internet Connection',
                    );
                  } else {
                    await showErrorDialog(
                      context,
                      'Could not Resolve Error',
                    );
                  }
                  print(e.code);
                } catch (e) {
                  await showErrorDialog(
                    context,
                    'Could Not Login at the Moment',
                  );
                  print('Cannot Login at the Moment');
                }
              },
              child: const Text('Login')),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Don\'t have an Account? Register Here'))
        ],
      ),
    );
  }
}
