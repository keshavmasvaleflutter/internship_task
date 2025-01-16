import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Get.off(()=>HomeScreen());
    });
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 197, 197, 1),
      body: Center(
        child: Image.asset("assets/images/splash_screen_img.png"),
      ),
    );
  }
}
