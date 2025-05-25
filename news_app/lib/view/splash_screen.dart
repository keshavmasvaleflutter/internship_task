
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/view/signin.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(()=> const SignIn());
    });
    return Scaffold(
      body: Center(
        child: Image.asset("assets/app_logo.png"),
      ),
    );
  }
}