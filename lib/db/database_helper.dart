import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../models/user.dart';
import '../utils/constants.dart';

class DatabaseHelper{


  static final DatabaseHelper _databaseHelper = DatabaseHelper._init();
  DatabaseHelper._init();
  static  Database? _database;



  String userTable = "todo";
  String colId = "id";
  String colName = "name";
  int colPhone = 0;
  String colAddress = "address";


 Future<Database?> get database async{
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database;
 }

  Future<Database> initializeDatabase() async{
    final directory = await getDatabasesPath();
    String a = 'notes.db';
    String path = '$directory$a';

    //open/create  database at the given path
    return await openDatabase(path,version: 1,onCreate: _createDb);

  }

  Future _createDb(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName ( 
  $colId $idType, 
  $colName $textType,
  $colPhone $integerType,
  $colAddress $textType)''');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>?> getUserMapList() async {
    Database? db = await database;
    var result = await db?.query(userTable, orderBy: '$colName ASC');
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<User> ]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList();
    int? count = userMapList?.length;
    List<User> noteList = <User>[];
    for (int i = 0; i < count!; i++) {
      noteList.add(User.fromMap(userMapList![i]));
    }
    return noteList;
  }

  Future<List<User>> readAllUser() async {
    final db = await _databaseHelper.database;
    final orderBy = '$colName ASC';
    final result = await db?.query(tableName, orderBy: orderBy);

    List<User> users = [];
    result?.forEach((result) {
      User user = User.fromMap(result);
      users.add(user);
    });
    return users;
  }


  // Write Operation : Insert user data to db
  Future<int?> insertData(User user) async{
    Database? db = await database;
    var result = await db?.insert(userTable, user.toMap());
    return result;
  }


  //Update operation
  Future<int?> updateData(User user) async{
    Database? db = await database;
    var result = await db?.update(userTable, user.toMap(),where: '$colId = ?',whereArgs: [user.id]);
    return result;
  }

  // Delete operation
  Future<int?> deleteData(int id) async {
    Database? db = await database;
    var result = await db?.rawDelete('DELETE FROM $userTable WHERE $colId = $id' );
    return result;
  }

}