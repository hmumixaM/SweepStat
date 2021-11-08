import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

enum EntryType {experiment, config}

class ConfigSave {
  String title;
  double initialV, vertexV, finalV;
  double scanRate;
  int segmentCount;
  double sampleInterval;

  ConfigSave({String title, double initialV, double vertexV, double finalV, double scanRate, int segmentCount, double sampleInterval}){
    this.title = title;
    this.initialV = initialV;
    this.vertexV = vertexV;
    this.finalV = finalV;
    this.scanRate = scanRate;
    this.segmentCount = segmentCount;
    this.sampleInterval = sampleInterval;
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'initialV': initialV,
      'vertexV': vertexV,
      'finalV': finalV,
      'scanRate': scanRate,
      'segmentCount': segmentCount,
      'sampleInterval': sampleInterval,
    };
  }
}

class DBManager {
  static const DB_NAME = 'sweepstat.db';

  static Map<EntryType, String> objectToTableNameMap = {
    EntryType.experiment: 'experiments',
    EntryType.config: 'configs',
  };

  static Future<void> initTables(Database db) async {
    await db.execute(
        "CREATE TABLE experiments(id INTEGER PRIMARY KEY, title TEXT UNIQUE NOT NULL, initialV REAL NOT NULL, vertexV REAL NOT NULL, finalV REAL NOT NULL, scanRate REAL NOT NULL, segmentCount INTEGER NOT NULL, sampleInterval REAL NOT NULL, datapoints TEXT NOT NULL)");
    return await db.execute(""
        "CREATE TABLE configs(id INTEGER PRIMARY KEY, title TEXT UNIQUE NOT NULL, initialV REAL NOT NULL, vertexV REAL NOT NULL, finalV REAL NOT NULL, scanRate REAL NOT NULL, segmentCount INTEGER NOT NULL, sampleInterval REAL NOT NULL)");

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

  static Future<void> addObject(Database db, EntryType type, Map<String, dynamic> object) async {
    String table = objectToTableNameMap[type];
    return await db.insert(table, object, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteObject(Database db, EntryType type, String title) async{
    String table = objectToTableNameMap[type];
    return await db.delete('configs', where: 'title=?', whereArgs: [title]);
  }
}
