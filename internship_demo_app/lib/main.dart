import 'package:flutter/material.dart';
import 'package:internship_demo_app/view/signin_page.dart';
import 'model/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDatabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
    );
  }
}
