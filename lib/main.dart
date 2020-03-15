import 'package:flutter/material.dart';
import 'package:flutter_moor_provider/data/task_db.dart';
import 'package:flutter_moor_provider/pages/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<TaskDatabase>(
      create: (_) =>
          TaskDatabase(), //creating an access of AppDatabase for all decendent widgets
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
