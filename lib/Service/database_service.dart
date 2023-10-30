import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper dbHelper = DBHelper._();

  DBHelper._();

  Database? database;

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await createDB();
    }
  }

  Future<Database> createDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "user.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,dob TEXT,password TEXT,confirmpass TEXT)";

        db.execute(query);
      },
    );
  }

  void insertData({
    required name,
    required email,
    required dob,
    required password,
    required confirmpass,
  }) async {
    database = await checkDB();
    database!.insert("user", {
      "name": name,
      "email": email,
      "dob": dob,
      "password": password,
      "confirmpass": confirmpass,
    });
  }

  Future<List<Map>> ReadData() async {
    database = await checkDB();

    String query = "SELECT * FROM user";
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future<void> deleteData({required id}) async {
    database = await checkDB();
    database!.delete("user", where: "id=?", whereArgs: [id]);
  }

  Future<List<Map>> getUsersByDate() async {
    database = await checkDB();
    List<Map> list = await database!.query('user', orderBy: 'dob DESC');

    return list;
  }

  void updateData({
    required id,
    required name,
    required email,
    required dob,
    required password,
    required confirmpass,
  }) {
    database!.update(
      "user",
      {
        "name": name,
        "email": email,
        "dob": dob,
        "password": password,
        "confirmpass": confirmpass,
      },
      whereArgs: [id],
      where: "id=?",
    );
  }
}
