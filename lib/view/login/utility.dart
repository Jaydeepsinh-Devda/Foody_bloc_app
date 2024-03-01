import 'package:foody_bloc_app/constants/regular_expressions.dart';

class Utility {
  static String? emailValidation(String? value) {
    if ((value ?? '').isNotEmpty &&
        RegExp(RegularExpressions.emailRegExp).hasMatch(value!.trim())) {
      return null;
    }
    return "Invalid Email. Please try again";
  }

  static String? passwordValidation(String? value) {
    if ((value ?? '').isNotEmpty &&
        RegExp(RegularExpressions.passwordRegExp).hasMatch(value!.trim() )) {
      return null;
    }
    return "Invalid Password. Please try again";
  }
}
