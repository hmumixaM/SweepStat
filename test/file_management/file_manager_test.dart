import 'package:flutter_test/flutter_test.dart';
import 'package:sweep_stat_app/file_management/file_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async{

  sqfliteFfiInit();
  Database db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  await DBManager.initTables(db);
  List initQuery = await db.query('sqlite_master', where: 'name=?', whereArgs: ['configs']);
  test("database is successfully initialized", () {
    expect(initQuery.length == 1, true);
  });

  var input = ConfigSave(
    title: "Valid Test Input",
    initialV: .5,
    vertexV: 2.5,
    finalV: .5,
    scanRate: .2,
    sampleInterval: .01,
    segmentCount: 6,
  );
  await DBManager.addObject(db, EntryType.config, input.toMap());
  List addQuery = await db.query('configs', where: 'title=?', whereArgs: ["Valid Test Input"]);
  test("valid input is successfully stored", () {
    expect(addQuery.length == 1, true);
  });

  await DBManager.deleteObject(db, EntryType.config, input.title);
  List deleteQuery = await db.query('configs', where: 'title=?', whereArgs: ["Valid Test Input"]);
  test("existing input is successfully deleted/nonexistent object not found", () {
    expect(deleteQuery.length == 0, true);
  });
}