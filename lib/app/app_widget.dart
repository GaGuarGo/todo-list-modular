import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_modular/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_modular/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_modular/app/modules/auth/auth_module.dart';
import 'package:todo_list_modular/app/modules/home/home_module.dart';
import 'package:todo_list_modular/app/modules/splash/splash_page.dart';
import 'package:todo_list_modular/app/modules/tasks/tasks_module.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo List Modular',
        navigatorKey: TodoListNavigator.navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR')
        ],
        routes: {
          ...AuthModule().routers,
          ...HomeModule().routers,
          ...TasksModule().routers,
        },
        home: const SplashPage(),
        theme: TodoListUiConfig.theme);
  }
}
