import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/services/services.dart';
import 'package:news_app/view/view.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Image.asset("assets/app_logo.png",height: screenHeight*0.2, width: screenWidth*1,),
            Text(
              "Sign in",
              style: textTheme.displayLarge?.copyWith(
                color: colorScheme.onPrimary,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight*0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth*0.035, right: screenWidth*0.035),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text(
                        "Enter your email",
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    cursorColor: colorScheme.onPrimary,
                    style: TextStyle(color: colorScheme.onPrimary,),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 23.h,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: Text("Enter your password",
                        style: textTheme.bodyMedium,
                      ),
                      suffix: Text(
                        "Forgot?",
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppColors.pinkAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onPrimary,),
                    cursorColor: colorScheme.onPrimary,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18.h,
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
                          Get.offAll(() => const HomeScreen());
                          emailController.clear();
                          passwordController.clear();
                        } else {
                          Get.snackbar(
                            "Login Failed",
                            "Invalid email or password",
                            colorText: colorScheme.onPrimary,
                            backgroundColor: colorScheme.surface,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        Get.snackbar(
                          "Error",
                          "Email and Password fields cannot be empty",
                          colorText: colorScheme.onPrimary,
                          backgroundColor: Colors.black,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColors.buttonColor),
                      minimumSize: WidgetStatePropertyAll(Size(screenWidth*0.95,
                            screenHeight*0.06)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)))),
                      side:
                         WidgetStatePropertyAll(BorderSide(color: colorScheme.onPrimary)),
                    ),
                    child: Text(
                      "Sign in",
                      style: textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 18.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const Signup());
                          emailController.clear();
                          passwordController.clear();
                        },
                        child: Text(
                          "Create now",
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.pinkAccent,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
