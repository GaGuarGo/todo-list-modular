import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.grey)],
      ),
      child: IntrinsicHeight(
        child: CheckboxListTile(
          contentPadding: const EdgeInsets.all(8),
          value: true,
          onChanged: (value) {},
          title: const Text(
            "Descrição da TASK",
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: const Text(
            "20/07/2024",
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1)),
        ),
      ),
    );
  }
}
