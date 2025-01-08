import 'dart:async';

import 'package:advance_task_manager/controller/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => HomePageState();
}

class HomePageState extends State {
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 220, 206),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Task",
                    style: GoogleFonts.lobster(
                        fontSize: 100,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 228, 141, 18)),
                  ),
                  Text(
                    "Manager",
                    style: GoogleFonts.lobster(
                        fontSize: 100,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 228, 141, 18)),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
