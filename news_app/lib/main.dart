import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.withOpacity(0.2),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lora(color: Colors.white),
          displayMedium: GoogleFonts.lora(color: Colors.white),
          displaySmall: GoogleFonts.lora(color: Colors.white),
          headlineLarge: GoogleFonts.lora(color: Colors.white),
          headlineMedium: GoogleFonts.lora(color: Colors.white),
          headlineSmall: GoogleFonts.lora(color: Colors.white),
          titleLarge: GoogleFonts.lora(color: Colors.white),
          titleMedium: GoogleFonts.lora(color: Colors.white),
          titleSmall: GoogleFonts.lora(color: Colors.white),
          bodyMedium: GoogleFonts.lora(color: Colors.white),
          bodySmall: GoogleFonts.lora(color: Colors.white),
          labelLarge: GoogleFonts.lora(color: Colors.white),
          labelMedium: GoogleFonts.lora(color: Colors.white),
          labelSmall: GoogleFonts.lora(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w300,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
    );
  }
}




// https://newsdata.io/api/1/news?apikey=pub_608265b02da58221848cf897aefb877e1743c&country=in&language=en,hi,mr&category=business,crime,education,politics,science
// https://newsdata.io/api/1/latest?apikey=pub_608265b02da58221848cf897aefb877e1743c

// https://newsapi.org/v2/everything?q=tesla&from=2024-12-16&sortBy=publishedAt&apiKey=eb714cee1349404399bee1937dfd7a9a