import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "movie.db";
  static const _databaseVersion = 1;
  static const _favorite_movies_table = 'favorite_movies';

  static const fieldMovieId = "movie_id";

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_favorite_movies_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $fieldMovieId INT
           )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future insert(int movieId) async {
    // Get a reference to the database.
    final Database? db = await instance.database;

    try {
      await db!.insert(
        _favorite_movies_table,
        {fieldMovieId: movieId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Db Inserted');
    } catch (e) {
      print('DbException' + e.toString());
    }
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(_favorite_movies_table);
  }

  Future<List<Map<String, dynamic>>> queryFilterRows(int movieId) async {
    Database? db = await instance.database;
    return await db!.rawQuery(
      "select * from $_favorite_movies_table where $fieldMovieId=$movieId",
    );
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $_favorite_movies_table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnId];
  //   return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  // }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_favorite_movies_table);
  }
}
