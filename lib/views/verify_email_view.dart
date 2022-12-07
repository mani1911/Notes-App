import 'package:flutter/material.dart';
import 'package:learndart/constants/routes.dart';
import 'package:learndart/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text(
              'We\'ve sent an Email Verification to the Registered Account. Kindly Verify Email to proceed further.'),
          const Text('Did\'nt receive a Verification Email? Press Below'),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              print(user);
              AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send Email Verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
