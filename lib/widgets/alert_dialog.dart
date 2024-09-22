import 'package:flutter/material.dart';
import 'package:todo_app/widgets/alert_button.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.controller,
  });
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      backgroundColor: Colors.yellow[300],
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Add new task',
        ),
      ),
      actions: [
        AlertButton(
          onPressed: onCancel,
          title: 'Cancel',
        ),
        AlertButton(
          onPressed: onSave,
          title: 'Save',
        ),
      ],
    );
  }
}
