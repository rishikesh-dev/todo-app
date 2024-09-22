import 'package:flutter/material.dart';

class DesktopTodoTile extends StatelessWidget {
  const DesktopTodoTile({
    super.key,
    required this.taskName,
    required this.onChanged,
    required this.taskCompleted,
    required this.onDelete,
  });
  final String taskName;
  final Function(bool?) onChanged;
  final bool taskCompleted;
  final Function(BuildContext) onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 221, 67),
        ),
        child: Row(
          children: [
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
            ),
            Text(
              taskName,
              style: TextStyle(
                fontSize: 20,
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                onDelete(context);
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
