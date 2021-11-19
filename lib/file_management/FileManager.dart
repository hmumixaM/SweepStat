import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sweep_stat_app/experiment_settings.dart';

enum EntryType {experiment, config}

class DBManager {
  static const DB_NAME = 'sweepstat.db';

  static Map<EntryType, String> objectToTableNameMap = {
    EntryType.experiment: 'experiments',
    EntryType.config: 'configs',
  };

  static Future<void> initTables(Database db) async {
    await db.execute(
        "CREATE TABLE experiments(id INTEGER PRIMARY KEY, type TEXT NOT NULL, title TEXT UNIQUE NOT NULL, initialVoltage REAL NOT NULL, vertexVoltage REAL, finalVoltage REAL, scanRate REAL, sweepSegments INTEGER, sampleInterval REAL NOT NULL, gainSetting TEXT NOT NULL, electrode TEXT NOT NULL, dataPoints TEXT NOT NULL)");
    return await db.execute(""
        "CREATE TABLE configs(id INTEGER PRIMARY KEY, type TEXT NOT NULL, title TEXT UNIQUE NOT NULL, initialVoltage REAL NOT NULL, vertexVoltage REAL, finalVoltage REAL, scanRate REAL, sweepSegments INTEGER, gainSetting TEXT NOT NULL, electrode TEXT NOT NULL, sampleInterval REAL NOT NULL, runtime REAL)");
  }

  static Future<Database> startDBConnection() async {
    return await openDatabase(
      join((await getExternalStorageDirectory()).path, 'sweepstat.db'),
      onCreate: (db, version) async {
        await initTables(db);
      },
      version: 1,
    );
  }

  static Future<void> closeDBConnection(Database db) async {
    return await db.close();
  }

  static Future<void> addObject(Database db, EntryType type, Map<String, dynamic> object) async {
    String table = objectToTableNameMap[type];
    return await db.insert(table, object, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteObject(Database db, EntryType type, String title) async{
    String table = objectToTableNameMap[type];
    return await db.delete('configs', where: 'title=?', whereArgs: [title]);
  }

  static Future<Map> queryExpectOneResult(Database db, EntryType type, String title) async{
    String table = objectToTableNameMap[type];
    return (await db.query(table, where: "title=?", whereArgs: [title])).first;
  }

  static Future<List> queryEntireTable(Database db, EntryType type) async{
    String table = objectToTableNameMap[type];
    return (await db.query(table, where: null));
  }
}
