

import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class UserDatabase{

  static final UserDatabase instance = UserDatabase._init();
  UserDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async{
    final directory = await getDatabasesPath();
    String a = 'user.db';
    String path = '$directory$a';

    return await openDatabase(path,version: 1,onCreate: _createDb);

  }

  String userTable = "todo";
  String colId = "id";
  String colName = "name";
  int colPhone = 0;
  String colAddress = "address";

  Future _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName ( 
  $colId $idType, 
  $colName $textType,
  $colPhone $integerType,
  $colAddress $textType)''');
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;
    final orderBy = '$colName ASC';
    final result = await db.query(tableName, orderBy: orderBy);

    List<User> users = [];
    result.forEach((result) {
      User user = User.fromMap(result);
      users.add(user);
    });
    return users;
  }


  // Write Operation : Insert user data to db
  Future<int?> insertData(User user) async{
    Database? db = await database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}