import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Modular',
      home: const SplashPage(),
      theme: ThemeData(
        useMaterial3: false,
      ),
    );
  }
}
