import 'package:crm/utils/constants/texts.dart';

class TValidator {
  /// Validates the email.
  static String? validateNick(String? value) {
    if (value == null || value.isEmpty) {
      return TTexts.nickValidate;
    }
    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    //   return 'Please enter a valid email';
    // }
    return null;
  }

  /// Validates the password.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return TTexts.passwordValidateEmpty;
    }

    return null;
  }
}
