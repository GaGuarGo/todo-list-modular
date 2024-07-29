import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';
import 'package:todo_list_modular/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var firstDate = DateTime.now().subtract(const Duration(days: 20 * 365));
        var lastDate = DateTime.now().add(const Duration(days: 10 * 365));

        final DateTime? selectedDate = await showDatePicker(
            context: context, firstDate: firstDate, lastDate: lastDate);

        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.today, color: Colors.grey),
            const SizedBox(width: 10),
            Selector<TaskCreateController, String>(
              selector: (context, controller) {
                return controller.selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(controller.selectedDate!)
                    : "SELECIONE UMA DATA";
              },
              builder: (BuildContext context, value, Widget? child) {
                return Text(
                  value,
                  style: context.titleStyle,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
