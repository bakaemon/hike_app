import 'package:flutter/material.dart';
import 'package:hike_app/util/navigation.dart';
import 'package:sqflite/sqflite.dart';

import '../database/repository/hike_repo.dart';
import '../widgets/fixed_page.dart';
import '../widgets/scrollpage.dart';
import 'hike_form.dart';

class HikeListScreen extends StatefulWidget {
  const HikeListScreen({Key? key, required this.database}) : super(key: key);

  final Database database;

  @override
  _HikeListScreenState createState() => _HikeListScreenState();
}

class _HikeListScreenState extends State<HikeListScreen> {
  late HikeRepo _repository;
  @override
  void initState() {
    super.initState();
    _repository = HikeRepo(db: widget.database);
  }

  @override
  Widget build(BuildContext context) {
    return FixedPage(
      titleText: 'Hike List',
      body: FutureBuilder(
        future: _repository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index].name ?? 'N/A'),
                  subtitle: Text(snapshot.data?[index].location ?? 'N/A'),
                  trailing: IconButton(
                    onPressed: () {
                      if (snapshot.data?[index].id != null) {
                        _repository.delete(snapshot.data![index].id!);
                      }
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await navigate<void>(
            context,
            HikeForm(
              db: widget.database,
            ),
            animation: NavigationAnimation.slideLeft,
          );
          setState(() {
            // refresh list
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
