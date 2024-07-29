import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/modules/todo_list_module.dart';
import 'package:todo_list_modular/app/modules/home/home_controller.dart';
import 'package:todo_list_modular/app/modules/home/home_page.dart';
import 'package:todo_list_modular/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list_modular/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list_modular/app/services/tasks/tasks_service.dart';
import 'package:todo_list_modular/app/services/tasks/tasks_service_impl.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(bindings: [
          Provider<TasksRepository>(
            create: (context) => TasksRepositoryImpl(
              sqliteConnectionFactory: context.read(),
            ),
          ),
          Provider<TasksService>(
            create: (context) => TasksServiceImpl(
              tasksRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeController(taskService: context.read()),
          )
        ], routers: {
          '/home': (context) => HomePage(
                homeController: context.read(),
              )
        });
}
