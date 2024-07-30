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

  bool showFinishingTasks = false;

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
      if (selectedDate != null) {
        filterByDay(selectedDate!);
      } else if (initialDayWeek != null) {
        filterByDay(initialDayWeek!);
      }
    } else {
      selectedDate = null;
    }

    if (!showFinishingTasks) {
      filteredTasks.retainWhere((task) => !task.finished);
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

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  Future<void> deleteTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    await _tasksService.delete(task);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishingTasks() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
  }
}
