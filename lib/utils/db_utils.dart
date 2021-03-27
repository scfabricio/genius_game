import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBUtils {
  static const String _dbname = "geniusgame.db";

  static Future<sql.Database> _database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, _dbname),
      version: 1,
      onCreate: (db, version) {
        return db.execute("CREATE TABLE genius (maxscore int)");
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBUtils._database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, Map<String, dynamic> data) async {
    final db = await DBUtils._database();
    await db.update(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBUtils._database();
    return db.query(table);
  }
}
