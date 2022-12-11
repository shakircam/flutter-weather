import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/user.dart';

class DatabaseHelper{
  static late DatabaseHelper _databaseHelper ;
  static late Database _database;

  DatabaseHelper._createInstance();

  String userTable = "user_table";
  String colId = "id";
  String colTitle = "title";
  String colDes = "description";
  String colPriority = "priority";


  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance(); // This will execute once, Singleton object
    }
    return _databaseHelper;
  }
 Future<Database> get database async{
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
      await db.execute('CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDes TEXT, $colPriority TEXT)');
  }

  // Read Operation
  Future<List<Map<String, dynamic>>> readDataList() async {
    Database db = await database;
    var result = await db.query(userTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Write Operation
  Future<int> insertData(User user) async{
    Database db = await database;
    var result = await db.insert(userTable, user.toMap());
    return result;
  }

  //Update operation
  Future<int> updateData(User user) async{
    Database db = await database;
    var result = await db.update(userTable, user.toMap(),where: '$colId = ?',whereArgs: [user.id]);
    return result;
  }

  // Delete operation
  Future<int> deleteNote(int id) async {
    Database db = await database;
    var result = await db.rawDelete('DELETE FROM $userTable WHERE $colId = $id' );
    return result;
  }

}