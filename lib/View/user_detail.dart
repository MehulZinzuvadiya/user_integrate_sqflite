import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_integrate_sqflite/Service/database_service.dart';
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
    dataController.readSubUser();
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name:",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "Email:",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "DOB:",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "Age:",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "Password:",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  content: dataController.subDataList.length != null
                                                      ? ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              dataController.subDataList.length,
                                                          itemBuilder: (context, subindex) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets.only(bottom: 5),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 6,
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.blue.shade200,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                      ),
                                                                      child: Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                10),
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          child: Row(
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment
                                                                                        .start,
                                                                                children: [
                                                                                  Text(
                                                                                    "Name:",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                  Text(
                                                                                    "Email:",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                  Text(
                                                                                    "DOB:",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                  Text(
                                                                                    "Password:",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 30,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment
                                                                                        .start,
                                                                                children: [
                                                                                  Text(
                                                                                    "${dataController.subDataList[subindex]['name']}",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                  Text(
                                                                                    "${dataController.subDataList[subindex]['email']}",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                  Text(
                                                                                    "${dataController.subDataList[subindex]['dob']}",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
                                                                                  ),
                                                                                  Text(
                                                                                    "${dataController.subDataList[subindex]['password']}",
                                                                                    style: GoogleFonts
                                                                                        .poppins(
                                                                                            fontSize:
                                                                                                14),
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
                                                                              dataController
                                                                                      .userIndex =
                                                                                  dataController
                                                                                          .subDataList[
                                                                                      index]['id'];

                                                                              HomeController
                                                                                      .homecontroller
                                                                                      .isUserUpdate =
                                                                                  true;

                                                                              HomeController
                                                                                      .homecontroller
                                                                                      .txtup_name =
                                                                                  TextEditingController(
                                                                                text: dataController
                                                                                        .subDataList[
                                                                                    subindex]['name'],
                                                                              );

                                                                              HomeController
                                                                                      .homecontroller
                                                                                      .txtup_email =
                                                                                  TextEditingController(
                                                                                text: dataController
                                                                                        .subDataList[
                                                                                    subindex]['email'],
                                                                              );
                                                                              HomeController
                                                                                      .homecontroller
                                                                                      .txtup_password =
                                                                                  TextEditingController(
                                                                                text: dataController
                                                                                            .subDataList[
                                                                                        subindex]
                                                                                    ['password'],
                                                                              );
                                                                              Navigator.of(context)
                                                                                  .pushNamed(
                                                                                      '/subRegister');
                                                                            });
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons.edit)),
                                                                      IconButton(
                                                                          onPressed: () {
                                                                            showDialog(
                                                                              builder: (context) =>
                                                                                  AlertDialog(
                                                                                title: const Text(
                                                                                    'Are you sure?'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () =>
                                                                                        Navigator.pop(
                                                                                            context),
                                                                                    // Closes the dialog
                                                                                    child:
                                                                                        const Text(
                                                                                            'No'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      setState(() {
                                                                                        DBHelper
                                                                                            .dbHelper
                                                                                            .deleteSubUser(
                                                                                                id: dataController.subDataList[subindex]['id']);
                                                                                        dataController
                                                                                            .readSubUser();
                                                                                      });
                                                                                      Navigator.pop(
                                                                                          context);
                                                                                      Navigator.pop(
                                                                                          context);
                                                                                    },
                                                                                    child:
                                                                                        const Text(
                                                                                            'Yes'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              context: context,
                                                                            );
                                                                          },
                                                                          icon: const Icon(
                                                                              Icons.delete)),
                                                                    ],
                                                                  )),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : const Text(
                                                          "UserData Is Not Found",
                                                        ),
                                                );
                                              });
                                        },
                                        child: Text(
                                          "Count:",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18, color: Colors.blue.shade400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${dataController.datalist[index]['name']}",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${dataController.datalist[index]['email']}",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${dataController.datalist[index]['dob']}",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${HomeController.homecontroller.calculateAge(DateTime.parse(dataController.datalist[index]['dob']))}",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${dataController.datalist[index]['password']}",
                                        style: GoogleFonts.poppins(fontSize: 18),
                                      ),
                                      Text(
                                        "${0}",
                                        style: GoogleFonts.poppins(fontSize: 18),
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

                                  HomeController.homecontroller.txtup_name = TextEditingController(
                                    text: dataController.datalist[index]['name'],
                                  );

                                  HomeController.homecontroller.txtup_email = TextEditingController(
                                      text: dataController.datalist[index]['email']);

                                  HomeController.homecontroller.txtup_confirmPass =
                                      TextEditingController(
                                          text: dataController.datalist[index]['password']);

                                  HomeController.homecontroller.selectedDate =
                                      DateTime.parse("${dataController.datalist[index]['dob']}");

                                  HomeController.homecontroller.txtup_password =
                                      TextEditingController(
                                    text: dataController.datalist[index]['password'],
                                  );
                                  HomeController.homecontroller.tabController.animateTo(1);
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
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/subRegister');
                              dataController.userIndex = dataController.subDataList
                                  .indexOf(dataController.subDataList[index]);
                            },
                            icon: const Icon(Icons.add),
                          ),
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
