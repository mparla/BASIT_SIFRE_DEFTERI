import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class Record {

  int _id;
  String _name;
  String _pass;


  Record(this._name, this._pass );

  Record.withId(this._id, this._name, this._pass);

  int get id => _id;

  String get name => _name;

  String get pass => _pass;




  set name(String newName) {
    if (newName.length <= 50) {
      this._name = newName;
    }
  }
  set pass(String newPass) {
    if (newPass.length <= 50) {
      this._pass = newPass;
    }
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['pass'] = _pass;

    return map;
  }

  // Extract a Note object from a Map object
  Record.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._pass = map['pass'];
  }
}

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String recordTable = 'record_table';
  String colId = 'id';
  String colName = 'name';
  String colPass = 'pass';


  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    final directory = await getDatabasesPath();    //getApplicationDocumentsDirectory();
    String path = directory + 'Records.db';

    // Open/create the database at a given path
    var RecordsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return RecordsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $recordTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colPass TEXT)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getRecordMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(recordTable, orderBy: '$colName ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertRecord(Record record) async {
    Database db = await this.database;
    var result = await db.insert(recordTable, record.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateRecord(Record record) async {
    var db = await this.database;
    var result = await db.update(recordTable, record.toMap(), where: '$colId = ?', whereArgs: [record.id]);
    return result;
  }


  // Delete Operation: Delete a todo object from database
  Future<int> deleteRecord(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $recordTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $recordTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Record>> getRecordList() async {

    var recordMapList = await getRecordMapList(); // Get 'Map List' from database
    int count = recordMapList.length;         // Count the number of map entries in db table

    List<Record> recordList = []; // List<Record>(); burayı değiştirdim
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      recordList.add(Record.fromMapObject(recordMapList[i]));
    }

    return recordList;
  }

}