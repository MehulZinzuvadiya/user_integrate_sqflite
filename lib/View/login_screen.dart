import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_integrate_sqflite/Controller/data_controller.dart';

import '../Controller/home_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  TextStyle poppins = GoogleFonts.poppins();
  bool passwordShow = true;

  DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue.shade200),
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller:
                                HomeController.homecontroller.txtlogin_email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Email';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              hintStyle: poppins,
                            ),
                          ),
                          TextFormField(
                            controller:
                                HomeController.homecontroller.txtlogin_password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Password';
                              }
                            },
                            obscureText: passwordShow,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(passwordShow
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordShow = !passwordShow;
                                  });
                                },
                              ),
                              hintText: 'Enter Your Password',
                              hintStyle: poppins,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  bool isUserValid = false;

                                  for (Map user in controller.datalist) {
                                    if (user["email"] ==
                                            HomeController.homecontroller
                                                .txtlogin_email.text &&
                                        user["password"] ==
                                            HomeController.homecontroller
                                                .txtlogin_password.text) {
                                      isUserValid = true;
                                      break;
                                    }
                                  }
                                  String? username =
                                      HomeController.homecontroller.getUser(
                                          HomeController.homecontroller
                                              .txtlogin_email.text,
                                          HomeController.homecontroller
                                              .txtlogin_password.text);

                                  if (isUserValid) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          const Text("Login Successfull !!"),
                                      backgroundColor: Colors.green.shade200,
                                    ));
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          title: const Text("Welcome Back !!"),
                                          content: Text("${username}"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  HomeController.homecontroller
                                                      .txtlogin_email
                                                      .clear();
                                                  HomeController.homecontroller
                                                      .txtlogin_password
                                                      .clear();
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: GoogleFonts.poppins(),
                                                )),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red.shade300,
                                      content: Text(
                                        'Invalid email or password',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ));
                                  }
                                }
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
