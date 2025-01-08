import 'package:advance_task_manager/view/advanceApp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:task_manager/toDoApp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

final TextEditingController _username = TextEditingController();
final TextEditingController _name = TextEditingController();
final TextEditingController _password = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
List<Map> login = [];

class _LoginPageState extends State {
  bool flag = false;
  Scaffold returnScaffold() {
    if (flag == false) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign",
                            style: GoogleFonts.lobster(
                              fontSize: 100,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "In",
                            style: GoogleFonts.lobster(
                                fontSize: 100,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 228, 141, 18)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Username ",
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Eneter Username",
                          label: const Text("Eneter Username"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter UserName";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: _password,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Eneter Password",
                          label: const Text("Eneter Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  bool loginValidated =
                                      _formKey.currentState!.validate();
                                  checkverify();

                                  if (loginValidated && verify) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const AdvanceToDoList())));
                                    clearControler();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content:
                                                Text("Login Succesfully")));
                                    verify = false;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Login Failled"),
                                      ),
                                    );
                                  }
                                  setState(() {});
                                },
                                child: Text(
                                  "SignIn",
                                  style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 2,
                                width: 200,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _password.clear();
                                  _username.clear();
                                  flag = true;
                                  setState(() {});
                                },
                                child: Text(
                                  "SignUp",
                                  style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Container(
                //           height: 60,
                //           width: 60,
                //           decoration: const BoxDecoration(
                //               image: DecorationImage(
                //                   image: AssetImage(
                //                     "images/3d-square-with-facebook-logo_125540-1565.avif",
                //                   ),
                //                   fit: BoxFit.cover)),
                //         ),
                //         Container(
                //           height: 60,
                //           width: 60,
                //           decoration: const BoxDecoration(
                //               image: DecorationImage(
                //                   image: AssetImage(
                //                     "images/Google__G__logo.svg.webp",
                //                   ),
                //                   fit: BoxFit.cover)),
                //         ),
                //         Container(
                //           height: 60,
                //           width: 60,
                //           decoration: const BoxDecoration(
                //               image: DecorationImage(
                //                   image: AssetImage(
                //                     "images/twitter.jpg",
                //                   ),
                //                   fit: BoxFit.cover)),
                //         ),
                //       ],
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 220, 206),
      );
    } else {
      //SignUp
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 220, 206),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign",
                        style: GoogleFonts.lobster(
                          fontSize: 100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Up",
                        style: GoogleFonts.lobster(
                            fontSize: 100,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 228, 141, 18)),
                      )
                    ],
                  ),
                  Text(
                    "Name ",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Eneter name",
                      label: const Text("Eneter name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Text(
                    "Username ",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Eneter Username",
                      label: const Text("Eneter Username"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter UserName";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password ",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: _password,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Eneter Password",
                      label: const Text("Eneter Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              bool loginValidated =
                                  _formKey1.currentState!.validate();

                              if (loginValidated) {
                                Map data = {
                                  "name": _name.text,
                                  _username.text: _password.text,
                                };
                                login.add(data);
                                //clear controller
                                _name.clear();
                                _password.clear();
                                _username.clear();
                                flag = !flag;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("SignUp Succesfully"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Fill given Information"),
                                  ),
                                );
                              }

                              setState(() {});
                            },
                            child: Text(
                              "SignUp",
                              style: GoogleFonts.poppins(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: 200,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              flag = !flag;
                              setState(() {});
                            },
                            child: Text(
                              "SignIn",
                              style: GoogleFonts.poppins(
                                  fontSize: 25, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  bool verify = false;
  void clearControler() {
    _username.clear();
    _password.clear();
    _name.clear();
  }

  void checkverify() {
    for (int i = 0; i < login.length; i++) {
      if (login[i][_username.text] == _password.text) {
        nameOfUser = login[i]["name"];
        verify = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return returnScaffold();
  }
}

String nameOfUser = "";
