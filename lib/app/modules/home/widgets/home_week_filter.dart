import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';
import 'package:todo_list_modular/app/models/task_filter_enum.dart';
import 'package:todo_list_modular/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  DateTime getInialWeekDay() {
    DateTime date = DateTime.now();

    if (date.weekday == 1) {
      return date;
    }

    while (date.weekday != 1) {
      date = date.subtract(const Duration(days: 1));
    }

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
          (controller) => controller.selectedFilter == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "DIA DA SEMANA",
            style: context.titleStyle,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 95,
            child: DatePicker(
              getInialWeekDay(),
              initialSelectedDate: DateTime.now(),
              locale: 'pt_BR',
              selectedTextColor: Colors.white,
              selectionColor: context.primaryColor,
              daysCount: 7,
              monthTextStyle: const TextStyle(fontSize: 8),
              dayTextStyle: const TextStyle(fontSize: 13),
              dateTextStyle: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
