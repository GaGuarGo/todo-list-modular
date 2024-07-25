import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_modular/app/core/ui/theme_extensions.dart';

class Messages {
  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  final BuildContext context;

  showSuccess({required String message}) => _showMessage(
        title: 'Sucesso',
        message: message,
        color: Colors.green,
        icon: CupertinoIcons.check_mark_circled_solid,
      );

  showIdle({required String message}) => _showMessage(
      title: 'Informando',
      message: message,
      color: context.primaryColor,
      icon: CupertinoIcons.info_circle_fill);

  showFail({required String message}) => _showMessage(
        title: 'Erro',
        message: message,
        color: Colors.red,
        icon: CupertinoIcons.clear_thick_circled,
      );

  void _showMessage(
      {required String title,
      required String message,
      required Color color,
      required IconData icon}) {
    Flushbar(
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: color,
      isDismissible: true,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      title: title,
      titleColor: Colors.white,
      message: message,
      messageColor: Colors.white,
    ).show(context);
  }
}
