// @dart=2.9
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  // static Database? _database;
  static Database _database;

  DbProvider._privateConstructor();
  static final DbProvider instance = DbProvider._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansDb.db');
    print(path);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );
        ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel scan) async {
    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans(id,tipo,valor)
      VALUES($id,'$tipo','$valor')
    ''');
    print(res);
    return res;
  }

  Future<int> nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    print(res);

    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansType(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.update('Scans', scanModel.toJson(),
        where: 'id=?', whereArgs: [scanModel.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    // final res = await db.delete('Scans');
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
