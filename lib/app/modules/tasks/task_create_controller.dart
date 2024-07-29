import 'dart:developer';

import 'package:todo_list_modular/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_modular/app/services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaskCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? date) {
    resetState();
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save({required String description}) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (selectedDate != null) {
        await _tasksService.save(selectedDate!, description);
        success();
      } else {
        setError('Data é Obrigatória');
      }
    } on Exception catch (e, s) {
      log(e.toString(), stackTrace: s);
      setError('Erro ao Cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
