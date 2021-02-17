import 'package:news/src/resources/news_api_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache  {
  Database _database;

  NewsDbProvider() {
   init();
  }

  void init() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items1.db");
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database _newDb, int version) {
        _newDb.execute("""
          CREATE TABLE Items 
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      }
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await _database.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if(maps.length > 0) {
      ItemModel.fromDb(maps.first);
    }

    return null;
  }
  
  Future<int> addItem(ItemModel item) {
    return _database.insert(
        "Items",
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    return null;
  }

}

final newsDbProvider = NewsDbProvider();