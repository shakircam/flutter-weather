

import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class UserDatabase{

  static final UserDatabase instance = UserDatabase._init();
  UserDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final directory = await getDatabasesPath();

    String path = '$directory$filePath';

    return await openDatabase(path,version: 1,onCreate: _createDB);

  }


  String colId = 'id';
  String colName = 'name';
  String colPhone = 'phone';
  String colAddress = 'address';


  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
  CREATE TABLE $tableName ( 
  id $idType, 
  name $textType,
  phone $textType,
  address $textType )
  ''');
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;
    const orderBy = 'name ASC';
    final result = await db.query(tableName, orderBy: orderBy);

    List<User> users = [];
    for (var result in result) {
      User user = User.fromJson(result);
      users.add(user);
    }
    return users;
  }

  // Write operation
  Future<int?> insertData(User user) async {
    final db = await instance.database;
    final id = await db.insert(userTable, user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}