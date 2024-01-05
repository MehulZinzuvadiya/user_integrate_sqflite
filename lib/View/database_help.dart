import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Users {
  int id;
  String name;
  String email;
  String dob;
  String password;
  String confirmpassword;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.password,
    required this.confirmpassword,
  });

  factory Users.fromMap(Map data) {
    return Users(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      dob: data['dob'],
      password: data['password'],
      confirmpassword: data['confirmpassword'],
    );
  }
}

class SubUsers {
  int id;
  int uid;
  String name;
  String email;
  String dob;
  String password;
  String confirmpassword;

  SubUsers({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.dob,
    required this.password,
    required this.confirmpassword,
  });

  factory SubUsers.fromMap(Map data) {
    return SubUsers(
      id: data['id'],
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      dob: data['dob'],
      password: data['password'],
      confirmpassword: data['confirmpassword'],
    );
  }
}

class UserData {
  UserData._();

  static final UserData userdata = UserData._();
  static Database? db;
  final String dbname = "userdata.db";
  final String subDbName = "subuserdata.db";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formsubkey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  bool isupdate = false;
  bool isuserexist = false;
  int index = 0;

  List<SubUsers> allsubusers = [];
  List<Users> allusers = [];

  var data;
  String user = "";
  RegExp emailregExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late TabController tabController;

  Future initdb() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbname);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String quary =
            "CREATE TABLE IF NOT EXISTS Users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,dob TEXT , password TEXT,confirmpassword TEXT,count INTEGER );";

        await db.execute(quary);
      },
    );
    return db;
  }

  Future initsubdb() async {
    String directory = await getDatabasesPath();
    String path = join(directory, subDbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String quary =
            "CREATE TABLE IF NOT EXISTS SubUsers(id INTEGER PRIMARY KEY AUTOINCREMENT,uid INTEGER, name TEXT,email TEXT,dob TEXT , password TEXT,confirmpassword TEXT );";

        await db.execute(quary);
      },
    );
    return db;
  }

  Future insertuser(
      {required String name,
        required String email,
        required String dob,
        required String password,
        required String confirmpassword}) async {
    db = await initdb();
    String quary =
        "INSERT INTO Users (name,email,dob,password,confirmpassword) VALUES (?,?,?,?,?);";
    List args = [name, email, dob, password, confirmpassword];
    return await db!.rawInsert(quary, args);
  }

  Future insertSubUser({
    required int uid,
    required String name,
    required String email,
    required String dob,
    required String password,
    required String confirmpassword,
  }) async {
    db = await initsubdb();
    String quary =
        "INSERT INTO SubUsers (uid,name,email,dob,password,confirmpassword) VALUES (?,?,?,?,?,?);";
    List args = [uid, name, email, dob, password, confirmpassword];
    return await db!.rawInsert(quary, args);
  }

  Future<List<Users>> fetchusersbyage() async {
    db = await initdb();
    List data = await db!.query('Users', orderBy: 'dob DESC');
    allusers = data.map((e) => Users.fromMap(e)).toList();

    return allusers;
  }

  Future<List<Users>> filteruser(String value) async {
    db = await initdb();
    List data = await db!.query('Users', where: "name = ?", whereArgs: [value]);
    allusers = data.map((e) => Users.fromMap(e)).toList();

    return allusers;
  }

  Future<List<SubUsers>> fetchsubusersbyage({required int id}) async {
    db = await initsubdb();
    String quary = "SELECT * FROM SubUsers WHERE uid = ?";
    List args = [id];

    List subdata = await db!.rawQuery(quary, args);
    allsubusers = subdata.map((e) => SubUsers.fromMap(e)).toList();
    return allsubusers;
  }

  Future deleteuser({required int id}) async {
    db = await initdb();
    String quary = "DELETE FROM Users WHERE id = $id";
    return await db!.rawDelete(quary);
  }

  Future deleteuserwithsubuser({required int uid}) async {
    db = await initsubdb();
    String quary = "DELETE FROM SubUsers WHERE uid = $uid";
    return await db!.rawQuery(quary);
  }

  Future deletesubuser({required int id}) async {
    db = await initsubdb();
    String quary = "DELETE FROM SubUsers WHERE id = $id";
    return await db!.rawQuery(quary);
  }

  Future updateuser(
      {required String upname,
        required String upemail,
        required String updob,
        required String uppassword,
        required String upconfirmpassword,
        required int id}) async {
    db = await initdb();
    String quary =
        "UPDATE Users SET name= ? ,email=?,dob=?,password=?,confirmpassword=? WHERE id =?";
    List args = [upname, upemail, updob, uppassword, upconfirmpassword, id];
    return await db!.rawUpdate(quary, args);
  }

  Future updatesubuser(
      {required String upname,
        required String upemail,
        required String updob,
        required String uppassword,
        required String upconfirmpassword,
        required int id}) async {
    db = await initsubdb();
    String quary =
        "UPDATE SubUsers SET name= ? ,email=?,dob=?,password=?,confirmpassword=? WHERE id =?";
    List args = [upname, upemail, updob, uppassword, upconfirmpassword, id];
    return await db!.rawUpdate(quary, args);
  }

  bool isAdult(DateTime birthDateString) {
    String datePattern = "M/d/yyyy";

    DateTime birthDate = birthDateString;
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 18 ||
        yearDiff == 18 && monthDiff > 0 ||
        yearDiff == 18 && monthDiff == 0 && dayDiff >= 0;
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

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> users = await dbClient!.query(
      'Users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }
}
