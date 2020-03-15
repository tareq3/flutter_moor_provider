import 'package:flutter_moor_provider/data/task_db.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'todos_dao.g.dart';

@UseDao(tables: [Todos])
class TodosDao extends DatabaseAccessor<TaskDatabase> with _$TodosDaoMixin {
  TodosDao(TaskDatabase db) : super(db);

  Future<List<Todo>> getAllTasks() => select(todos).get();

  Stream<List<Todo>> watchAllTasks() => select(todos).watch();

  Future insertTask(Todo todo) => into(todos).insert(todo);

  Future updateTask(Todo todo) => update(todos).replace(todo);

  Future deleteTask(Todo todo) => delete(todos).delete(todo);
}
