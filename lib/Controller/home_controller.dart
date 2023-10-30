import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_integrate_sqflite/Controller/data_controller.dart';

class HomeController {
  HomeController._();

  static final homecontroller = HomeController._();
  late TabController tabController;

  DateTime selectedDate = DateTime.now();

  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_confirmPass = TextEditingController();
  TextEditingController intialdateval = TextEditingController();

  TextEditingController txtlogin_email = TextEditingController();
  TextEditingController txtlogin_password = TextEditingController();

  TextEditingController txtup_name = TextEditingController();
  TextEditingController txtup_email = TextEditingController();
  TextEditingController txtup_password = TextEditingController();
  TextEditingController txtup_confirmPass = TextEditingController();

  String us_password = '';
  String us_email = '';
  String username = '';
  int index = 0;

  bool isUpdate = false;

  String? encodeData;
  String? decodeData;
  int? age;

  DataController dataController = Get.put(DataController());

  // Future<void> setData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   encodeData = json.encode(userList);
  //   await prefs.setString("dataList", encodeData!);
  // }

  // Future<void> getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   decodeData = await prefs.getString('dataList');
  //   userList = json.decode(decodeData!);
  // }

  // void addUser() {
  //   userList.add({
  //     "name": txt_name.text,
  //     "email": txt_email.text,
  //     "password": txt_password.text,
  //     "age": age,
  //     "Dob": DateFormat("d/M/yyyy").format(selectedDate),
  //     "date": selectedDate.toString(),
  //     // "Dob": selectedDate,
  //   });
  //   setData();
  // }
  //
  // void updateUser(int index) {
  //   userList[index] = ({
  //     "name": txtup_name.text,
  //     "email": txtup_email.text,
  //     "Dob": DateFormat("d/M/yyyy").format(selectedDate),
  //     "password": txtup_password.text,
  //     "confirm": txtup_confirmPass,
  //     "age": age,
  //     "date": selectedDate.toString(),
  //   });
  //   setData();
  // }
  //
  // void deleteData(int index) {
  //   userList.removeAt(index);
  //   setData();
  // }

  String? getUser(String email, String password) {
    for (var user in dataController.datalist) {
      us_email = user['email'];
      us_password = user['password'];
      if (user['email'] == email && user['password'] == password) {
        username = user['name'];
        break;
      }
    }
    return username;
  }

  bool isAdult(DateTime birthDateString) {
    String datePattern = "d/M/yyyy";

    DateTime birthDate = birthDateString;
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 18 ||
        yearDiff == 18 && monthDiff > 0 ||
        yearDiff == 18 && monthDiff == 0 && dayDiff >= 0;
  }

  void sort() {
    dataController.datalist.value
        .sort((a, b) => (a['age']).compareTo(b['age']));
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;

    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;

      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
