import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  final String label;

  final IconButton? suffixIconButton;
  final Icon? suffixIcon;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  TodoListField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.suffixIcon,
    this.controller,
    this.validator,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não poede ser enviado em conjunto com o suffixIconButton'),
        obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
            isDense: true,
            suffixIcon: suffixIcon ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                        icon: Icon(obscureTextValue
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash),
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
