import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch (state) {
     
      // TODO: Handle this case.
      case AppLifecycleState.resumed:
      // TODO: Handle this case.
       case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        connection.closeConnection();
        break;
      case AppLifecycleState.hidden:
    }

    super.didChangeAppLifecycleState(state);
  }
}
