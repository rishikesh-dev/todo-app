import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  const AlertButton({super.key, required this.onPressed, required this.title});
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[400],
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
