import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldName;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextField({
    required this.textFieldName,
    required this.validator,
    this.obscureText = false,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text(),
        _textField(),
      ],
    );
  }

  Widget _text() => Text(
        textFieldName,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      );

  Widget _textField() => TextFormField(
        validator: validator,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
