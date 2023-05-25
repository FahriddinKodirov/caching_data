import 'package:caching_data/data/model/categories_model/catrgories_model.dart';
import 'package:caching_data/data/model/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static String tableName = 'users';
  static LocalDatabase getInstance = LocalDatabase.init();

  Database? _database;
  LocalDatabase.init();

  Future<Database> getDb() async {
    if (_database == null) {
      _database = await _initDb('users.db');
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        String textType = 'TEXT';
        String intType = 'INTEGER';
        String boolType = 'INTEGER';

        await db.execute('''
        CREATE TABLE $tableName (
          ${UserFields.id} $idType,
          ${UserFields.name} $textType,
          ${UserFields.imageUrl} $textType,
          ${UserFields.createdAt} $textType
        )
    ''');
      },
    );
    return database;
  }

  static Future<CategoryModel> insertCategories({required CategoryModel categoryModel}) async {
    var database = await getInstance.getDb();
    int id = await database.insert(tableName, categoryModel.toJson());
    debugPrint('ADD BOLDI HAMMASI YAXSHI');
    return categoryModel.copyWith(id: id);
  }

  static Future<List<CategoryModel>> getCachedCategories() async {
    var database = await getInstance.getDb();

    var listofTodos = await database.query(tableName, columns: [
      UserFields.id,
      UserFields.name,
      UserFields.imageUrl,
      UserFields.createdAt,
    ]);

    var list = listofTodos.map((e) => CategoryModel.fromJson(e)).toList();

    return list;
  }

  static Future<List<CategoryModel>> getTaskByTitle({String title = ''}) async {
    var database = await getInstance.getDb();

    if (title.isNotEmpty) {
      var listofTodos = await database.query(
        tableName,
        where: 'title LIKE ?',
        whereArgs: ['%$title%'],
      );
      var list = listofTodos.map((e) => CategoryModel.fromJson(e)).toList();
      return list;
    } else {
      var listofTodos = await database.query(
        tableName,
        columns: [
          UserFields.id,
          UserFields.name,
          UserFields.imageUrl,
          UserFields.createdAt,
        ],
      );
      var list = listofTodos.map((e) => CategoryModel.fromJson(e)).toList();
      return list;
    }
  }

  static Future<int> deleteContactById({required int id}) async {
     var database = await getInstance.getDb();

     return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAll() async {
    var database = await getInstance.getDb();
    return await database.delete(tableName);
  }
}
