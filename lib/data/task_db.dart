// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".

import 'package:flutter_moor_provider/data/dao/todos_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'task_db.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

/*// This will make moor generate a class called "Category" to represent a row in this table.
// By default, "Categorie" would have been used because it only strips away the trailing "s"
// in the table name.
@DataClassName("Category")
class Categories extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}*/

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [Todos], daos: [TodosDao])
class TaskDatabase extends _$TaskDatabase {
  // we tell the database where to store the data with this constructor
  TaskDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
  // we tell the database where to store the data with this constructor

}
