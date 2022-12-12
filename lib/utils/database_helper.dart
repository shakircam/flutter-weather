import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class DatabaseHelper{

  static  Database? _database;

  String userTable = "user_table";
  String colId = "id";
  String colName = "name";
  String colPhone = "phone";
  String colAddress = "address";

  static final DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    return _databaseHelper;
  }

 Future<Database?> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
 }

  Future<Database> initializeDatabase() async{
    // Get the directory path both ios & android to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}notes.db';

    //open/create  database at the given path
    var notesDatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return notesDatabase;

  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colPhone TEXT, $colAddress TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>?> getUserMapList() async {
    Database? db = await database;
    var result = await db?.query(userTable, orderBy: '$colName ASC');
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<User>> getUserList() async {
    // Get 'Map List' from database
    var userMapList = await getUserMapList();
    // Count the number of map entries in db table
    int? count = userMapList?.length;

    List<User> noteList = <User>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count!; i++) {
      noteList.add(User.fromMap(userMapList![i]));
    }
    return noteList;
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
  Future<int?> deleteNote(int id) async {
    Database? db = await database;
    var result = await db?.rawDelete('DELETE FROM $userTable WHERE $colId = $id' );
    return result;
  }

}