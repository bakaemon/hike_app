import 'package:flutter/material.dart';
import 'package:hike_app/database/db.dart';
import 'package:hike_app/pages/hike_list_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    database: await AppDatabase.instance,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});

  final Database database;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HikeListScreen(
        database: database,
      ),
    );
  }
}
