import 'package:todo_list_modular/app/models/task_model.dart';
import 'package:todo_list_modular/app/models/week_task_model.dart';

abstract interface class TasksService {
  Future<void> save(DateTime date, String description);

  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> checkOrUncheckTask(TaskModel task);
  Future<void> delete(TaskModel task);
}
