import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/firebase_db.dart';
import 'package:news_app/view/homepage.dart';
import 'package:news_app/view/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State createState() => _SignInState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          const Text(
            "Sign in",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.035, right: MediaQuery.sizeOf(context).width*0.035),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 23,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    suffix: Text(
                      "Forgot?",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1.0),
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      bool isValid = await FirebaseDB.signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      if (isValid) {
                        Get.to(() => const HomePage());
                        emailController.clear();
                        passwordController.clear();
                      } else {
                        Get.snackbar(
                          "Login Failed",
                          "Invalid email or password",
                          colorText: Colors.white,
                          backgroundColor: Colors.black,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Error",
                        "Email and Password fields cannot be empty",
                        colorText: Colors.white,
                        backgroundColor: Colors.black,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromRGBO(9, 9, 22, 1)),
                    minimumSize: WidgetStatePropertyAll(Size(400, 50)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                    side:
                        WidgetStatePropertyAll(BorderSide(color: Colors.white)),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(255, 255, 255, 1.0),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.off(() => const Signup());
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: const Text(
                        "Create now",
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
