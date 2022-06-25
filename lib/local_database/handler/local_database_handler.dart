import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHandler {
  static late Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    // Create [CurrentImage] table
    await db.execute(
        "CREATE TABLE CurrentImages(id TEXT PRIMARY KEY, image TEXT, timestamp TEXT, is_shoot_through_fast_camera BOOLEAN, low_res_image TEXT )");
    // Create [Folders] table
    await db.execute(
        "CREATE TABLE Folders(id TEXT PRIMARY KEY, folder_name TEXT, created_on TEXT, modified_on TEXT )");
  }
}

final localDatabaseHandler = LocalDatabaseHandler();
