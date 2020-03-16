import 'package:flutter_moor_provider/data/task_db.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'todos_dao.g.dart';

@UseDao(tables: [Todos])
class TodosDao extends DatabaseAccessor<TaskDatabase> with _$TodosDaoMixin {
  TodosDao(TaskDatabase db) : super(db);

  //queries

  Future<List<Todo>> getAllTasks() => select(todos).get();

  Stream<List<Todo>> watchAllTasks() => select(todos).watch();

  Future insertTask(Todo todo) => into(todos).insert(todo);

  Future updateTask(Todo todo) => update(todos).replace(todo);

  Future deleteTask(Todo todo) => delete(todos).delete(todo);

  //advance queries
  Stream<List<Todo>> watchAllCompletedTasks() {
    return (select(todos)
          ..orderBy(
            ([
              //primary sorting due date
              (todo) => OrderingTerm(
                  expression: todo.dueDate, mode: OrderingMode.desc),
              //secondary sorting due alphabatically
              (todo) => OrderingTerm(expression: todo.title)
            ]),
          )
          ..where((todo) => todo.completed.equals(true)))
        .watch();
  }

  //advacnce custom queries
  Stream<List<Todo>> watchAllCompletedTasksCustom(bool isComplete) {
    return customSelectQuery(
      'SELECT * FROM todos WHERE completed = ${isComplete ? '1' : '0'} ORDER BY due_date DESC, title;',
      readsFrom: {todos},
    )
        // customSelect or customSelectStream gives us QueryRow list
        // This runs each time the Stream emits a new value.
        .map(//turning the data into a Todo object
            (row) => Todo.fromData(row.data, db))
        .watch();
  }
}
