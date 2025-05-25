import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/config/config.dart';
import 'package:news_app/services/services.dart';
import 'package:news_app/view/view.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  
  @override
  State createState() => _SignupState();
}

class _SignupState extends State {

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedValue;

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Image.asset(
              "assets/app_logo.png",
              height: screenHeight * 0.2,
              width: screenWidth * 1,
            ),
            Text(
              "Sign up",
              style: textTheme.headlineLarge!.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              )
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.035,
                  right: screenWidth * 0.035,
                ),
              child: Column(
                children: [
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      label: Text(
                        "Enter Your Username",
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    cursorColor: AppColors.primaryLight,
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text(
                        "Enter Your Email",
                      style: textTheme.bodyMedium,
                      ),
                    ),
                    cursorColor: AppColors.primaryLight,
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Select the country",
                    ),
                    dropdownColor: AppColors.grey.withAlpha(30),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: <String>[
                      'India',
                      'USA',
                      'England',
                      'China',
                      'Russia',
                      'Japan',
                      'Pakistan',
                      'Nepal',
                      'Shrilanka',
                      'Afganistan',
                      'Ukrain',
                      'France',
                      'Isrel',
                      'Brazil',
                      'South Africa',
                      'Maldiv',
                      'Scotland'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: textTheme.bodyMedium!.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: Text(
                        "Enter Your Password",
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    cursorColor: AppColors.primaryLight,
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          userNameController.text.isNotEmpty &&
                          selectedValue!.isNotEmpty) {
                        bool isValid = await FirebaseDB.signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          userName: userNameController.text.trim(),
                          country: selectedValue!,
                        );
                        if (isValid) {
                          Get.offAll(() => const HomeScreen());
                          userNameController.clear();
                          emailController.clear();
                          selectedValue = null;
                          passwordController.clear();
                        }
                      } else {
                        Get.snackbar(
                          "Error",
                          "Details cannot be empty",
                          colorText: AppColors.primaryLight,
                          backgroundColor: Colors.black,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        AppColors.buttonColor,
                      ),
                      minimumSize: WidgetStatePropertyAll(
                        Size(
                          screenWidth*0.95,
                          screenHeight*0.06
                        ),
                      ),
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      side: const WidgetStatePropertyAll(
                        BorderSide(color: AppColors.primaryLight),
                      ),
                    ),
                    child: Text(
                      "Sign up",
                      style: textTheme.titleLarge!.copyWith(
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 18,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(() => const SignIn());
                      userNameController.clear();
                      emailController.clear();
                      selectedValue = null;
                      passwordController.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "Sign in now",
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
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
