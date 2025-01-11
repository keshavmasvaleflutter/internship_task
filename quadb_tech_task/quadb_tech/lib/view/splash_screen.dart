import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(HomeScreen());
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logos_netflix.png', fit: BoxFit.cover),
      ),
    );
  }
}
