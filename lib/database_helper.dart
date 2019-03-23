import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:sqlite_sample/modals/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database _db;


  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'main2.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) {
    db.execute(
        'CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,password TEXT)');
    print('Table is created');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("USER", user.toMap());
    return res;
  }

  Future<bool> isCorrectUser(String username, String password) async {
    var dbClient = await db;
    await Future.delayed(Duration(seconds: 2));
    var res = await dbClient.rawQuery(
        "select * from USER WHERE username like '$username' and password like '$password'");
    if (res.length >0) {
      return true;
    }
    return false;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("USER");
    return res;
  }
}
