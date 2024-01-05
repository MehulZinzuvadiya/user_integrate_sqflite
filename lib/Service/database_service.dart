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
    return openDatabase(path, version: 2, onCreate: (db, version) {
      String query =
          "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,dob TEXT,password TEXT,confirmpass TEXT)";

      String subquery =
          "CREATE TABLE subUser(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER,name TEXT,email TEXT,dob TEXT,password TEXT)";
      db.execute(query);
      db.execute(subquery);
    });
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

  void insertsubUser({
    required name,
    required email,
    required dob,
    required password,
    required userId,
  }) async {
    database = await checkDB();
    database!.insert("subUser", {
      "name": name,
      "email": email,
      "dob": dob,
      "password": password,
      "userId": userId,
    });
  }

  Future<List<Map>> ReadData() async {
    database = await checkDB();

    String query = "SELECT * FROM user";
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future<List<Map>> ReadSubUser() async {
    database = await checkDB();

    String query = "SELECT * FROM subUser";
    List<Map> subList = await database!.rawQuery(query);
    return subList;
  }

  Future<void> deleteData({required id}) async {
    database = await checkDB();
    database!.delete("user", where: "id=?", whereArgs: [id]);
  }

  void deleteSubUser({required id}) async {
    database = await checkDB();
    database!.delete("subUser", where: "id=?", whereArgs: [id]);
  }

  Future<List<Map>> getUsersByDate() async {
    database = await checkDB();
    List<Map> list = await database!.query('user', orderBy: 'dob DESC');

    return list;
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(String email, String password) async {
    Database? dbClient = await database;
    List<Map<String, dynamic>> users = await dbClient!.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
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

  void updateSubUser({
    required id,
    required name,
    required email,
    required dob,
    required password,
  }) {
    database!.update(
      "subUser",
      {"name": name, "email": email, "dob": dob, "password": password},
      whereArgs: [id],
      where: "id=?",
    );
  }
}
