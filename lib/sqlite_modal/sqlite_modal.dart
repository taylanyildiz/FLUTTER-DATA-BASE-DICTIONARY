import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_dictionary_sql/sqlite_modal/word.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class SqlModal {
  static final String pathName = "dictionary.sqlite";
  static final String pathDirection = "assets/sqflite/$pathName";
  static Future<Database> accessSQL() async {
    print("copy starting");
    String pathDirectionApp = join(await getDatabasesPath(), pathName);
    if (await databaseExists(pathDirectionApp)) {
      print("database path exists");
    } else {
      ByteData data = await rootBundle.load(pathDirection);
      List<int> bytes =
          await data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(pathDirectionApp).writeAsBytes(bytes, flush: true);
    }
    return openDatabase(pathDirectionApp);
  }

  static Future<List<Word>> allWord() async {
    var database = await accessSQL();
    await database.delete("words", where: "word_id=?", whereArgs: [0]);
    List<Map<String, dynamic>> maps =
        await database.rawQuery("SELECT * FROM words");
    return List.generate(maps.length, (index) {
      var data = maps[index];
      return Word(
        word_id: data["word_id"],
        word_eng: data["word_eng"],
        word_tr: data["word_tr"],
      );
    });
  }

  static Future<void> addWord(String word_eng, String word_tr) async {
    var database = await accessSQL();

    var maps = Map<String, dynamic>();
    maps["word_eng"] = word_eng;
    maps["word_tr"] = word_tr;

    await database.insert("words", maps);
  }
}
