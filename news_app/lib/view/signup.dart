import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/services/firebase_db.dart';
import 'package:news_app/view/homepage.dart';
import 'package:news_app/view/signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State createState() => _SignupState();
}

TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String? selectedValue;

class _SignupState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              "Sign up",
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
                    controller: userNameController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter Your Username",
                      ),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("Enter Your Email"),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Select the country",
                    ),
                    dropdownColor: Colors.grey.withOpacity(0.3),
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
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter Your Password",
                      ),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
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
                          Get.to(() => const HomePage());
                          userNameController.clear();
                          emailController.clear();
                          selectedValue = null;
                          passwordController.clear();
                        }
                      } else {
                        Get.snackbar(
                          "Error",
                          "Details cannot be empty",
                          colorText: Colors.white,
                          backgroundColor: Colors.black,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color.fromRGBO(9, 9, 22, 1)),
                      minimumSize: WidgetStatePropertyAll(Size(MediaQuery.sizeOf(context).width*0.94, MediaQuery.sizeOf(context).width*0.1)),
                      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                      side: const WidgetStatePropertyAll(BorderSide(color: Colors.white)),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(() => const SignIn());
                      userNameController.clear();
                      emailController.clear();
                      selectedValue = null;
                      passwordController.clear();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Sign in now",
                          style: TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.w700),
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
