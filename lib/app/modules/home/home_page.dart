import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/auth/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
          child: Text('logout'),
          onPressed: () {
            context.read<TodoListAuthProvider>().logout();
          },
        ),
      ),
    );
  }
}
