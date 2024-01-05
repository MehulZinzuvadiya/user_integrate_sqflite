import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_integrate_sqflite/Controller/data_controller.dart';
import 'package:user_integrate_sqflite/Service/database_service.dart';

import '../Controller/home_controller.dart';

class SubRegisterScreen extends StatefulWidget {
  const SubRegisterScreen({super.key});

  @override
  State<SubRegisterScreen> createState() => _SubRegisterScreenState();
}

class _SubRegisterScreenState extends State<SubRegisterScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> updateformkey = GlobalKey<FormState>();

  List userList = [];

  int selectedIndex = 0;

  bool passwordVisible = false;
  bool passwordVisible1 = false;

  TextStyle poppins = GoogleFonts.poppins();

  DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: Colors.blue.shade200),
                  child: Form(
                    key: HomeController.homecontroller.isUserUpdate ? updateformkey : formkey,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: HomeController.homecontroller.isUserUpdate
                                ? HomeController.homecontroller.txtup_name
                                : HomeController.homecontroller.txt_name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Name';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Your Name',
                              hintStyle: GoogleFonts.poppins(),
                            ),
                          ),
                          TextFormField(
                            controller: HomeController.homecontroller.isUserUpdate
                                ? HomeController.homecontroller.txtup_email
                                : HomeController.homecontroller.txt_email,
                            validator: ValidationBuilder().required().email().build(),
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              hintStyle: GoogleFonts.poppins(),
                            ),
                          ),
                          DateTimeFormField(
                            initialValue: HomeController.homecontroller.isUserUpdate
                                ? HomeController.homecontroller.selectedDate
                                : null,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select date';
                              } else if (HomeController.homecontroller
                                      .isAdult(HomeController.homecontroller.selectedDate) !=
                                  true) {
                                return "Age must be 18";
                              }
                            },
                            onDateSelected: (value) {
                              HomeController.homecontroller.selectedDate = value;

                              HomeController.homecontroller.age = HomeController.homecontroller
                                  .calculateAge(HomeController.homecontroller.selectedDate);
                            },
                            mode: DateTimeFieldPickerMode.date,
                            decoration: InputDecoration(
                              hintText: 'Date Of Birth',
                              hintStyle: GoogleFonts.poppins(),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: HomeController.homecontroller.isUserUpdate
                                ? HomeController.homecontroller.txtup_password
                                : HomeController.homecontroller.txt_password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Password';
                              }
                            },
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon:
                                    Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              hintText: 'Enter Password',
                              hintStyle: poppins,
                            ),
                          ),
                          TextFormField(
                            controller: HomeController.homecontroller.isUserUpdate
                                ? HomeController.homecontroller.txtup_confirmPass
                                : HomeController.homecontroller.txt_confirmPass,
                            validator: (value) {
                              if (HomeController.homecontroller.isUserUpdate == true) {
                                if (value != HomeController.homecontroller.txtup_password.text) {
                                  return 'Enter Same Password';
                                }
                              } else {
                                if (value != HomeController.homecontroller.txt_password.text) {
                                  return 'Enter Same Password';
                                }
                              }
                            },
                            obscureText: passwordVisible1,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    passwordVisible1 ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible1 = !passwordVisible1;
                                  });
                                },
                              ),
                              hintText: 'Enter Confirm Password',
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
                                // dataController.readData();
                                if (HomeController.homecontroller.isUserUpdate == true) {
                                  if (updateformkey.currentState!.validate()) {
                                    Navigator.pop(context);
                                    setState(() {
                                      HomeController.homecontroller.age = HomeController
                                          .homecontroller
                                          .calculateAge(HomeController.homecontroller.selectedDate);
                                      print("index=${HomeController.homecontroller.index}");

                                      dataController.updateSubUser(
                                          id: dataController.userIndex,
                                          name: HomeController.homecontroller.txtup_name.text,
                                          email: HomeController.homecontroller.txtup_email.text,
                                          password:
                                              HomeController.homecontroller.txtup_password.text,
                                          dob: HomeController.homecontroller.selectedDate
                                              .toString());
                                    });
                                    HomeController.homecontroller.isUserUpdate = false;
                                    HomeController.homecontroller.txtup_name.clear();
                                    HomeController.homecontroller.txtup_email.clear();
                                    HomeController.homecontroller.txtup_password.clear();
                                    HomeController.homecontroller.txtup_confirmPass.clear();
                                  }
                                } else {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      HomeController.homecontroller.age = HomeController
                                          .homecontroller
                                          .calculateAge(HomeController.homecontroller.selectedDate);

                                      DBHelper.dbHelper.insertsubUser(
                                        userId: HomeController.homecontroller.index,
                                        name: HomeController.homecontroller.txt_name.text,
                                        email: HomeController.homecontroller.txt_email.text,
                                        dob: HomeController.homecontroller.selectedDate.toString(),
                                        password: HomeController.homecontroller.txt_password.text,
                                      );
                                    });
                                    HomeController.homecontroller.txt_name.clear();
                                    HomeController.homecontroller.txt_email.clear();
                                    HomeController.homecontroller.txt_password.clear();
                                    HomeController.homecontroller.txt_confirmPass.clear();
                                  }
                                }
                                Navigator.pop(context);
                                dataController.readSubUser();
                              },
                              child: HomeController.homecontroller.isUserUpdate
                                  ? Text(
                                      "Update",
                                      style: GoogleFonts.poppins(),
                                    )
                                  : Text(
                                      "Register",
                                      style: GoogleFonts.poppins(),
                                    )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
