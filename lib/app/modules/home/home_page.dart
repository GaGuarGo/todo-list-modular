import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';
import 'package:todo_list_modular/app/modules/home/home_controller.dart';
import 'package:todo_list_modular/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_modular/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_modular/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_modular/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_modular/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_modular/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;
  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/task/create', context);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget._homeController.loadTotalTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0xFFFAFBFE),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<bool>(
                    child: Text('Mostrar Tarefas Concluídas'))
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => _goToCreateTask(context),
        backgroundColor: context.primaryColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
