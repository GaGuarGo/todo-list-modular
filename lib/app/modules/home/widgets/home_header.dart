// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/auth/auth_provider.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Selector<TodoListAuthProvider, String>(
            selector: (context, authProvider) {
              return authProvider.user?.displayName ?? "Usuário";
            },
            builder: (context, value, child) => Text('E aí, $value!',
                style: context.textTheme.headline5
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
