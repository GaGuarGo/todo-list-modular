import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';
import 'package:todo_list_modular/app/models/task_filter_enum.dart';
import 'package:todo_list_modular/app/models/total_tasks_model.dart';
import 'package:todo_list_modular/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;
  const TodoCardFilter({
    super.key,
    required this.label,
    required this.taskFilter,
    this.totalTasksModel,
    required this.selected,
  });

  double _getPercentFinish() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final totalFinish = totalTasksModel?.totalTasksFinish ?? 0.1;

    if (total == 0) {
      return 0;
    }

    return totalFinish / total;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: selected ? context.primaryColor : Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey.withOpacity(.8),
            ),
            borderRadius: BorderRadiusDirectional.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${totalTasksModel?.totalTasks ?? 0} TASKS',
              style: context.titleStyle.copyWith(
                  fontSize: 10, color: selected ? Colors.white : Colors.grey),
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: _getPercentFinish()),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryLightColor
                      : Colors.grey.shade300,
                  value: value,
                  valueColor: AlwaysStoppedAnimation(
                      selected ? Colors.white : context.primaryColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
