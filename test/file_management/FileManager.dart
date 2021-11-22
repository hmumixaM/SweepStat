import 'package:flutter_test/flutter_test.dart';
import 'package:sweep_stat_app/file_management/FileManager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sweep_stat_app/experiment/ExperimentSettings.dart';

void main() async{

  sqfliteFfiInit();
  Database db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  await DBManager.initTables(db);
  List initQuery = await db.query('sqlite_master', where: 'name=?', whereArgs: ['configs']);
  test("database is successfully initialized", () {
    expect(initQuery.length == 1, true);
  });

  var validCVInput = VoltammetrySettings(
    initialVoltage: .5,
    vertexVoltage: 2.5,
    finalVoltage: .5,
    scanRate: .2,
    sampleInterval: .01,
    sweepSegments: 6,
    gainSetting: GainSettings.uA1,
    electrode: Electrode.silver,
  ).toDBMap("Valid CV Input");
  await DBManager.addObject(db, EntryType.config, validCVInput);
  Map addQuery1 = await DBManager.queryExpectOneResult(db, EntryType.config, validCVInput["title"]);
  test("valid CV config is successfully stored", () {
    expect(addQuery1["title"] == validCVInput["title"], true);
  });

  Map validAmperometryInput = AmperometrySettings(
    initialVoltage: .5,
    sampleInterval: .01,
    runtime: 3.6,
    gainSetting: GainSettings.uA1,
    electrode: Electrode.silver,
  ).toDBMap("Valid Amperometry Input");
  await DBManager.addObject(db, EntryType.config, validAmperometryInput);
  Map addQuery2 = await DBManager.queryExpectOneResult(db, EntryType.config, validAmperometryInput["title"]);
  test("valid amperometry config is successfully stored", () {
    expect(addQuery2["title"] == validAmperometryInput["title"], true);
  });

  List tableTestQuery = await DBManager.queryEntireTable(db, EntryType.config);
  test("table query returns successfully and accurately", () {
    expect(tableTestQuery.length == 2, true);
  });

  await DBManager.deleteObject(db, EntryType.config, validCVInput["title"]);
  List deleteQuery = await db.query('configs', where: 'title=?', whereArgs: [validCVInput["title"]]);
  test("existing input is successfully deleted/nonexistent object not found", () {
    expect(deleteQuery.length == 0, true);
  });
}