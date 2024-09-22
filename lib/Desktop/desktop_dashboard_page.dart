import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/widgets/alert_dialog.dart';
import 'package:todo_app/widgets/desktop_todo_tile.dart';

class DesktopDashboardPage extends StatefulWidget {
  const DesktopDashboardPage({super.key});

  @override
  State<DesktopDashboardPage> createState() => _DesktopDashboardPageState();
}

class _DesktopDashboardPageState extends State<DesktopDashboardPage> {
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

  // CheckBox Ticked or not
  void checkBoxValue(bool? value, int index) {
    setState(() {
      _db.todoItems[index][1] = !_db.todoItems[index][1];
    });
    _db.updateTodo();
  }

  // Save New Task
  void saveNewTask() {
    setState(() {
      _db.todoItems.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    _db.updateTodo();
  }

  // AlertBox function
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

  // Delete function
  void deleteTask(int index) {
    setState(() {
      _db.todoItems.removeAt(index);
      _db.updateTodo();
    });
  }

  // Get list of completed tasks
  List getCompletedTasks() {
    return _db.todoItems.where((item) => item[1] == true).toList();
  }

  List randomImages = [
    "https://images.pexels.com/photos/120049/pexels-photo-120049.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/15848619/pexels-photo-15848619/free-photo-of-two-humpback-whales-swimming-in-the-ocean.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/3299/postit-scrabble-to-do.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/2325447/pexels-photo-2325447.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1108572/pexels-photo-1108572.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ];

  @override
  Widget build(BuildContext context) {
    List completedTasks = getCompletedTasks();
    // Create a Random instance
    final random = Random();
    // Get a random index
    final randomIndex = random.nextInt(randomImages.length);

    return SafeArea(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Completed tasks column
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBar(
                      title: Text(
                        'To-do App',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Completed ${completedTasks.length}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(),
                    // Set the height of the ListView with a specific height constraint
                    SizedBox(
                      height: completedTasks.isNotEmpty
                          ? 200
                          : 0, // Adjust height as needed
                      child: ListView.builder(
                        itemCount: completedTasks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.yellow.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              style: ListTileStyle.drawer,
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                completedTasks[index][0],
                                style: GoogleFonts.sora(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: const Text('Completed'),
                              trailing: const Icon(Icons.done),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Todo items column
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage(
                    randomImages[randomIndex],
                    scale: 0.6,
                  ),
                  opacity: 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                itemCount: _db.todoItems.length,
                itemBuilder: (context, index) {
                  return DesktopTodoTile(
                    taskName: _db.todoItems[index][0],
                    onChanged: (value) => checkBoxValue(value, index),
                    taskCompleted: _db.todoItems[index][1],
                    onDelete: (context) => deleteTask(index),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openAlertBox,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
