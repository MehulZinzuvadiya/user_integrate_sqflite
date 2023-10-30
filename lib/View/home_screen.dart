import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_integrate_sqflite/View/register_screen.dart';
import 'package:user_integrate_sqflite/View/user_detail.dart';

import '../Controller/home_controller.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.homecontroller.tabController =
        TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sqflite User Integration",
            style: GoogleFonts.poppins(),
          ),
          bottom: TabBar(
              controller: HomeController.homecontroller.tabController,
              labelPadding: EdgeInsets.all(10),
              tabs: const [
                Icon(Icons.verified_user),
                Icon(Icons.person),
                Icon(Icons.group),
              ]),
        ),
        body: TabBarView(
          controller: HomeController.homecontroller.tabController,
          children: const [
            LoginScreen(),
            RegisterScreen(),
            UserDetail(),
          ],
        ),
      )),
    );
  }
}
