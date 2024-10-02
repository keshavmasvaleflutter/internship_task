import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_demo_app/view/navigaton_page.dart';
import '../view/signin_page.dart';

String? errorMessage;

Future<bool> _signIn() async {
  const String url = 'https://evika.onrender.com/api/auth/signin';
  final Map<String, dynamic> body = {
    "email": emailController.text,
    "password": passwordController.text,
  };
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<void> handleSignIn(context) async {
  bool success = await _signIn();
  if (success) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const NavigatonPage(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage!)),
    );
  }
}
