import 'package:todo_list_modular/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_modular/app/models/task_filter_enum.dart';
import 'package:todo_list_modular/app/models/task_model.dart';
import 'package:todo_list_modular/app/models/total_tasks_model.dart';
import 'package:todo_list_modular/app/models/week_task_model.dart';
import 'package:todo_list_modular/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;

  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  DateTime? initialDayWeek;
  DateTime? selectedDate;

  HomeController({required TasksService taskService})
      : _tasksService = taskService;

  TaskFilterEnum selectedFilter = TaskFilterEnum.today;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
        totalTasks: todayTasks.length,
        totalTasksFinish: todayTasks.where((task) => task.finished).length);
    tomorrowTotalTasks = TotalTasksModel(
        totalTasks: tomorrowTasks.length,
        totalTasksFinish: tomorrowTasks.where((task) => task.finished).length);
    weekTotalTasks = TotalTasksModel(
        totalTasks: weekTasks.tasks.length,
        totalTasksFinish:
            weekTasks.tasks.where((task) => task.finished).length);
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    selectedFilter = filter;
    notifyListeners();

    showLoading();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        tasks = weekModel.tasks;
        initialDayWeek = weekModel.startDate;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (initialDayWeek != null) {
        filterByDay(initialDayWeek!);
      }
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDate = date;

    filteredTasks = allTasks.where((task) {
      return task.dateTime == selectedDate;
    }).toList();

    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: selectedFilter);
    await loadTotalTasks();
    notifyListeners();
  }
}
