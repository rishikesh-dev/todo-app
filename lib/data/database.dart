import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List todoItems = [];
  final _myBox = Hive.box('myBox');
  //Reference the box
  void createNewBox() {
    todoItems = [];
  }

  void loadData() {
    todoItems = _myBox.get('Todo-Items');
  }

  void updateTodo() {
    _myBox.put('Todo-Items', todoItems);
  }
}
