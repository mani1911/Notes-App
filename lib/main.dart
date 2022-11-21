import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learndart/firebase_options.dart';
import 'package:learndart/views/login_view.dart';
import 'package:learndart/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HoemPage(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      }));
}

class HoemPage extends StatelessWidget {
  const HoemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
