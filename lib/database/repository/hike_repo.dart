import 'package:hike_app/database/entity/hike.dart';
import 'package:sqflite/sqflite.dart';

class HikeRepo {
  HikeRepo({required this.db});

  final Database db;

  // insert
  Future<void> insert(Hike hike) async {
    await db.insert(
      'hikes',
      hike.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update
  Future<void> update(Hike hike) async {
    await db.update(
      'hikes',
      hike.toMap(),
      where: 'id = ?',
      whereArgs: [hike.id],
    );
  }

  // delete
  Future<void> delete(int id) async {
    await db.delete(
      'hikes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // get all
  Future<List<Hike>> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query('hikes');

    return List.generate(maps.length, (i) {
      return Hike(
        id: maps[i]['id'],
        name: maps[i]['name'],
        location: maps[i]['location'],
        date: maps[i]['date'],
        length: maps[i]['length'],
        parking: maps[i]['parking'],
        desc: maps[i]['desc'],
        guide: maps[i]['guide'],
        difficulty: maps[i]['difficulty'],
      );
    });
  }

  // get by field
  Future<List<Hike>> getByField(String field, dynamic value) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'hikes',
      where: '$field = ?',
      whereArgs: [value],
    );

    return List.generate(maps.length, (i) {
      return Hike(
        id: maps[i]['id'],
        name: maps[i]['name'],
        location: maps[i]['location'],
        date: maps[i]['date'],
        length: maps[i]['length'],
        parking: maps[i]['parking'],
        desc: maps[i]['desc'],
        guide: maps[i]['guide'],
        difficulty: maps[i]['difficulty'],
      );
    });
  }
}
