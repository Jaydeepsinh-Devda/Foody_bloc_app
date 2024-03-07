import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: text,
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        const Size.fromHeight(50),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}