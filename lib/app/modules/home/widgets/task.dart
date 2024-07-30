import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/models/task_model.dart';
import 'package:todo_list_modular/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel task;
  const Task({super.key, required this.task});

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
          value: task.finished,
          onChanged: (value) =>
              context.read<HomeController>().checkOrUncheckTask(task),
          title: Text(
            task.description,
            style: TextStyle(
                decoration: task.finished
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          subtitle: Text(
            task.formattedDate,
            style: TextStyle(
                decoration: task.finished
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1)),
        ),
      ),
    );
  }
}
