import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/home_screen.dart';
import 'View/sub_register_view.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: false,
    ),
    getPages: [
      GetPage(
        name: '/',
        page: () => HomeScreen(),
      ),
      GetPage(
        name: '/subRegister',
        page: () => SubRegisterScreen(),
      ),
    ],
  ));
}
