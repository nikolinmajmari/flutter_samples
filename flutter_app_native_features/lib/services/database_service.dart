import 'dart:io';

import 'package:flutter_app_native_features/models/place.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "places.db"),version: 1,
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places ( id TEXT PRIMARY KEY, image text, title text);");
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DatabaseService.database();
    await database.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> get(table) async {
    final db = await DatabaseService.database();
    return db.query(table);
  }

  static Future<List<Place>> fetchAndSetPlaces() async {
    final List<Map<String,dynamic>> datalist =
    await DatabaseService.get(Tables.USER_PLACES);
    print("[services/database_service]$datalist");
    return datalist.map((e) => Place(id: e["id"],title: e["title"],image: File(e["image"]))).toList();
  }
  static Future<void> delete(String table, String id) async{
    final db = await DatabaseService.database();
   return  db.delete(table,where: "id ='$id'");
  }
}

class Tables {
  static const USER_PLACES = "user_places";
}
