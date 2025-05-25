import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/config/app_theme.dart';
import 'package:news_app/view/view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

// SwiftBrief App information
// This is a simple news app that fetches news articles from an API and displays them in a feed.
// It uses Firebase for backend services and GetX for state management.
// The app is designed to be responsive and works well on different screen sizes using the flutter_screenutil package.
// The app includes features like a splash screen, sign in, sign up, news feed, and detailed news view.
// The app is built using Flutter and follows best practices for MVC architecture and code organization.