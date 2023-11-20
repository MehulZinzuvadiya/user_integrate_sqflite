import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/data_controller.dart';
import '../Controller/home_controller.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  DataController dataController = Get.put(DataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataController.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // dataController.sortData();
        },
        child: const Icon(Icons.sync),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Obx(
            () => ListView.builder(
              itemCount: dataController.datalist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name:",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "Email:",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "DOB:",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "Age:",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "Password:",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${dataController.datalist[index]['name']}",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${dataController.datalist[index]['email']}",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${dataController.datalist[index]['dob']}",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${HomeController.homecontroller.calculateAge(DateTime.parse(dataController.datalist[index]['dob']))}",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${dataController.datalist[index]['password']}",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  HomeController.homecontroller.index =
                                      dataController.datalist[index]['id'];
                                  HomeController.homecontroller.isUpdate = true;

                                  HomeController.homecontroller.txtup_name =
                                      TextEditingController(
                                    text: dataController.datalist[index]
                                        ['name'],
                                  );

                                  HomeController.homecontroller.txtup_email =
                                      TextEditingController(
                                          text: dataController.datalist[index]
                                              ['email']);

                                  HomeController
                                          .homecontroller.txtup_confirmPass =
                                      TextEditingController(
                                          text: dataController.datalist[index]
                                              ['password']);

                                  HomeController.homecontroller.selectedDate =
                                      DateTime.parse(
                                          "${dataController.datalist[index]['dob']}");

                                  HomeController.homecontroller.txtup_password =
                                      TextEditingController(
                                    text: dataController.datalist[index]
                                        ['password'],
                                  );
                                  HomeController.homecontroller.tabController
                                      .animateTo(1);
                                });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  dataController.deleteData(
                                      id: dataController.datalist[index]['id']);
                                  dataController.readData();
                                });
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      )),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
