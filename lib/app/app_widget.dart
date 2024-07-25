import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List Modular',
      home: SplashPage(),
    );
  }
}
