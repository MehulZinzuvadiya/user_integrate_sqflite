import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DataBaseHelper1 {
  static final _dbname = 'subdata.db';
  static final _version = 2;

  DataBaseHelper1._privateConstructor();

  static final DataBaseHelper1 instance = DataBaseHelper1._privateConstructor();
  static Database? _databasenew1;

  Future<Database> get database async {
    if (_databasenew1 != null)
      return _databasenew1!;
    else {
      _databasenew1 = await intialdatabase();
      return _databasenew1!;
    }
  }

  intialdatabase() async {
    String path = join(await getDatabasesPath(), _dbname);
    return openDatabase(path, version: _version, onCreate: createTable);
  }

  Future createTable(Database db, int version) async {
    return await db.execute('''
     CREATE TABLE  sublistNew(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
  name TEXT,email TEXT,dob TEXT,password TEXT)
     ''');
  }

  Future insertSubData(int userIds, SubDataModel1 subDataModel) async {
    subDataModel.userId = await userIds;
    Database db = await instance.database;
    await db.insert('sublistNew', subDataModel.toMap());
  }

  // Future<int> insertSubuser(int userId, Map<String, dynamic> subuser) async {
  //   Database db = await database;
  //   subuser['userId'] = userId;
  //   return await db.insert('subusers', subuser);
  // }
  //
  // Future<int> updateSubuser(Map<String, dynamic> subuser) async {
  //   Database db = await database;
  //   return await db.update('subusers', subuser, where: 'id = ?', whereArgs: [subuser['id']]);
  // }
  //
  // Future<int> deleteSubuser(int subuserId) async {
  //   Database db = await database;
  //   return await db.delete('subusers', where: 'id = ?', whereArgs: [subuserId]);
  // }
  //
  // Future<List<Map<String, dynamic>>> getSubusersForUser(int userId) async {
  //   Database db = await database;
  //   return await db.query('subusers', where: 'userId = ?', whereArgs: [userId]);
  // }

  Future<List<Map<String, dynamic>>> getSubData(int userId) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> subuserRows = await db.query(
      'sublistNew',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return subuserRows;
  }

  Future subdelete(int deleteId) async {
    Database db = await instance.database;
    await db.delete('sublistNew', where: 'id=?', whereArgs: [deleteId]);
  }

  Future subDataUpdate(int id, SubDataModel1 model1) async {
    Database db = await instance.database;
    return await db.rawUpdate('UPDATE sublistNew SET name=?,email=?,dob=?,password=? WHERE id=?',
        [model1.name, model1.email, model1.dob, model1.password, id]);
  }

  Future getDataForLogin() async {
    Database db = await instance.database;
    return await db.query('sublistNew');
  }
}

class SubDataModel1 {
  String? name;
  String? email;
  String? dob;
  String? password;
  int? id;
  int? userId;

  SubDataModel1({this.name, this.email, this.dob, this.password, this.id, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'dob': dob,
      'password': password,
      'id': id,
      'userId': userId
    };
  }

  factory SubDataModel1.fromMap(Map<String, dynamic> map) {
    return SubDataModel1(
        name: map['name'],
        email: map['email'],
        dob: map['dob'],
        password: map['password'],
        userId: map['userId'],
        id: map['id']);
  }
}
