import 'package:flutter/material.dart';
import 'package:flutter_moor_provider/data/dao/todos_dao.dart';
import 'package:flutter_moor_provider/data/task_db.dart';
import 'package:flutter_moor_provider/pages/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodosDao>(
          create: (_) => TaskDatabase().todosDao,
        ),
        Provider<TaskDatabase>(
          create: (_) => TaskDatabase(),
        ),
      ],
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
