import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/widgets/alert_dialog.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class MobileDashboardPage extends StatefulWidget {
  const MobileDashboardPage({
    super.key,
  });

  @override
  State<MobileDashboardPage> createState() => _MobileDashboardPageState();
}

class _MobileDashboardPageState extends State<MobileDashboardPage> {
  final _controller = TextEditingController();
  final _db = Database();
  final _myBox = Hive.box('myBox');
  @override
  void initState() {
    super.initState();
    if (_myBox.get('Todo-Items') == null) {
      _db.createNewBox();
    } else {
      _db.loadData();
    }
  }

  //CheckBox Ticked or not
  checkBoxValue(bool? value, int index) {
    setState(() {
      _db.todoItems[index][1] = !_db.todoItems[index][1];
    });
    _db.updateTodo();
  }

  //Save New Task
  void saveNewTask() {
    setState(() {
      _db.todoItems.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    _db.updateTodo();
  }

  //AlertBox function
  void openAlertBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: Navigator.of(context).pop,
        );
      },
    );
  }

  // delete function
  void deleteTask(int index) {
    setState(() {
      _db.todoItems.removeAt(index);
      _db.updateTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('To-do App'),
          ),
          SliverList.builder(
            itemCount: _db.todoItems.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: _db.todoItems[index][0],
                onChanged: (value) => checkBoxValue(value, index),
                taskCompleted: _db.todoItems[index][1],
                onDelete: (context) => deleteTask(index),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAlertBox,
        child: const Icon(Icons.add),
      ),
    );
  }
}
