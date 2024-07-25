import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';

class TodoListSnackbar {
  TodoListSnackbar({required BuildContext context}) : _context = context;

  final BuildContext _context;

  showSuccess({required String message}) {
    Flushbar(
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.green,
      isDismissible: true,
      icon: const Icon(
        CupertinoIcons.check_mark_circled_solid,
        color: Colors.white,
      ),
      title: 'Successo',
      titleColor: Colors.white,
      message: message,
      messageColor: Colors.white,
    ).show(_context);
  }

  showIdle({required String message}) {
    Flushbar(
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: _context.primaryColor,
      isDismissible: true,
      icon: const Icon(
        CupertinoIcons.info_circle_fill,
        color: Colors.white,
      ),
      title: 'Informando',
      titleColor: Colors.white,
      message: message,
      messageColor: Colors.white,
    ).show(_context);
  }

  showFail({required String message}) {
    Flushbar(
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.red,
      isDismissible: true,
      icon: const Icon(
        CupertinoIcons.clear_thick_circled,
        color: Colors.white,
      ),
      title: 'Erro',
      titleColor: Colors.white,
      message: message,
      messageColor: Colors.white,
    ).show(_context);
  }
}
