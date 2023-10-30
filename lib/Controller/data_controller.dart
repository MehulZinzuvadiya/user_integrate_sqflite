import 'package:get/get.dart';
import 'package:user_integrate_sqflite/Service/database_service.dart';

class DataController extends GetxController {
  RxList<Map> datalist = <Map>[].obs;

  Future<void> readData() async {
    datalist.value = await DBHelper.dbHelper.ReadData();
    sortData();
    print(datalist);
  }

  Future<void> sortData() async {
    datalist.value = await DBHelper.dbHelper.getUsersByDate();
  }

  void deleteData({required id}) {
    DBHelper.dbHelper.deleteData(id: id);
  }

  void updateData({
    required id,
    required name,
    required email,
    required password,
    required confirmpass,
    required dob,
  }) {
    DBHelper.dbHelper.updateData(
        id: id,
        name: name,
        email: email,
        dob: dob,
        password: password,
        confirmpass: confirmpass);

    readData();
  }
}
