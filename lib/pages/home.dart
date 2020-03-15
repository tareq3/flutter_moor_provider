import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_moor_provider/data/dao/todos_dao.dart';
import 'package:flutter_moor_provider/data/task_db.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'new_task.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: _buildTaskList(context)), //Widget for showing all tasks
          NewTask(), //Widget for creating new task
        ],
      ),
    );
  }

  ///  Private widget Stream buildr which rebuild itself on data snapshot changes
  StreamBuilder<List<Todo>> _buildTaskList(BuildContext context) {
    final todo_dao = Provider.of<TodosDao>(
        context); //get object of AppDatabse using provider
    print(todo_dao.toString());
    return StreamBuilder(
      stream: todo_dao.watchAllTasks(), //watchAllTasks is a stream
      builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
        final tasks = snapshot.data ??
            List(); // if snapshot.data is not null return its value , Otherwise return a empty List()
        return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              //_ means context
              final itemTask = tasks[index];
              return _buildListItem(itemTask, todo_dao);
            });
      },
    );
  }

//Widget for List Item in the list
  Widget _buildListItem(Todo taskItem, TodosDao todo_dao) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () =>
              todo_dao.deleteTask(taskItem), //delete item from todo_dao
        )
      ],
      child: CheckboxListTile(
        title: Text(taskItem.title),
        subtitle: Text(taskItem.dueDate?.toString() ?? 'No Date'),
        value: taskItem.completed,
        onChanged: (newValue) {
          todo_dao.updateTask(taskItem.copyWith(completed: newValue));
        },
      ),
    );
  }
}
