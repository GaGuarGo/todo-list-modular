// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_modular/app/core/auth/auth_provider.dart';
import 'package:todo_list_modular/app/core/ui/messages.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';
import 'package:todo_list_modular/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>("");

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<TodoListAuthProvider, String>(
                  selector: (context, todoListAuthProvider) {
                    return todoListAuthProvider.user?.photoURL ??
                        'https://w7.pngwing.com/pngs/961/327/png-transparent-avatar-profile-profile-page-user-pinterest-twotone-icon.png';
                  },
                  builder: (_, value, __) => CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<TodoListAuthProvider, String>(
                      selector: (context, todoListAuthProvider) {
                        return todoListAuthProvider.user?.displayName ??
                            'Não Informado';
                      },
                      builder: (_, value, __) => Text(
                        value,
                        style: context.textTheme.subtitle2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("Alterar Nome"),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Digite o seu Nome',
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (nameVN.value.isEmpty) {
                              Messages.of(context)
                                  .showFail(message: 'Nome obrigatório');
                            } else {
                              Loader.show(context);
                              await context
                                  .read<UserService>()
                                  .updateDisplayName(nameVN.value);
                              Loader.hide();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Alterar'),
                        ),
                      ],
                    );
                  });
            },
            title: const Text('Alterar Nome'),
          ),
          ListTile(
            title: Text(
              'Sair',
              style: TextStyle(
                  color: context.primaryColor, fontWeight: FontWeight.bold),
            ),
            onTap: () => context.read<TodoListAuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}
