
import 'package:todo_list_modular/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_modular/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier{
  
  TaskFilterEnum selectedFilter = TaskFilterEnum.today;

}