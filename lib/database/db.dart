import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Future<Database> get instance async => await openDatabase(
        join(await getDatabasesPath(), 'hike_database.db'),
        onCreate: (db, version) {
          return db.execute(
            '''CREATE TABLE hikes(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              location TEXT,
              date TEXT,
              length LONG,
              parking BOOLEAN,
              desc TEXT,
              guide TEXT,
              difficulty TEXT
            )''',
          );
        },
        version: 1,
      );
}
