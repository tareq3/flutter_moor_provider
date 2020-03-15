import 'package:flutter/material.dart';
import 'package:flutter_moor_provider/data/dao/todos_dao.dart';
import 'package:flutter_moor_provider/data/task_db.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  DateTime newTaskDate;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[_buildTextField(context), _buildDateButton(context)],
      ),
    );
  }

  Expanded _buildTextField(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(hintText: 'Task Name'),
        onSubmitted: (inputName) {
          print('Submit');

          //final database = Provider.of<AppDatabase>(context);
          // print(database.toString() + "t");
          final task = Todo(
            title: inputName,
            dueDate: newTaskDate,
          );
          print(task.toString());

          Provider.of<TodosDao>(context, listen: false).insertTask(
              task); // Listen is false here, Means it will not be rerendered but it needs the access to the model or Bloc
          resetValuesAfterSubmit();
        },
      ),
    );
  }

  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () async {
        newTaskDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      newTaskDate = null;
      textEditingController.clear();
    });
  }
}
