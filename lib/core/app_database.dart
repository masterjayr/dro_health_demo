import 'package:dro_health/features/allDrugs/data/models/drug_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDBProvider {
  AppDBProvider._();
  static final AppDBProvider db = AppDBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'user.db'),
        onCreate: (db, version) async {
      await db.execute(
          ' CREATE TABLE bag(id INTEGER PRIMARY KEY, imageUrl TEXT, name TEXT, amount TEXT, type TEXT, price TEXT, quantity INTEGER)');
    }, version: 1);
  }

// add record to the local database
  Future<int> addDrug(Drug drug) async {
    final db = await database;
    int res = await db.insert('bag', drug.toMap());

    return res;
  }

//this return drug from the local db sqflite
  Future<List<Drug>> getDrugsInBag() async {
    final db = await database;
    List<Drug> drug;
    List<Map<String, dynamic>> result = await db.query('bag');
    if (result.length > 0) {
      drug = Drug.drugJsonParser(result);
    }
    return drug;
  }

  Future<int> updateDrug(int data, int id) async {
    final db = await database;
    // User user;
    int res;
    List<Map<String, dynamic>> result = await db.query('bag');
    if (result.length > 0) {
      res = await db.update('bag', {"quantity": data}, where: "id = \"$id\"");
    }
    return res;
  }

  Future<bool> delete(int id) async {
    final db = await database;

    db.delete('bag', where: "id = ?", whereArgs: [id]);

    return true;
  }
}

class AppDao {
  final AppDBProvider db;

  AppDao({this.db});

  Future<List<Drug>> getDrugsInBag() async {
    return await db.getDrugsInBag();
  }

  Future<bool> addDrug(Drug drug) async {
    print('Drug is ${drug.name}');
    return await db.addDrug(drug) > 0;
  }

  Future<bool> delete(int id) async {
    return await db.delete(id);
  }

  Future<int> updateDrug(int data, int id) async {
    return await db.updateDrug(data, id);
  }
}
