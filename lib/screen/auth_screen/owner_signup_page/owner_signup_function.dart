import 'package:antique_jo/screen/auth_screen/owner_signup_page/owner_signup_screen.dart';
import 'package:uuid/uuid.dart';

class SignUpFunction {
  static String? validateEmail(var value) {
    if (value.isEmpty) {
      return 'Email required';
    }

    if (!value.contains("@gmail.com")) {
      return 'Invalid email format. It must be like XX@XX.com';
    }

    return null;
  }

  static String generateUID() {
    const uuid = Uuid();
    return uuid.v4();
  }

  static bool isPasswordValid(String password) {
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*]');
    RegExp digitRegex = RegExp(r'\d');

    capitalLetterValid = uppercaseRegex.hasMatch(password);
    specialCharacterValid = specialCharRegex.hasMatch(password);
    numberValid = digitRegex.hasMatch(password);

    return capitalLetterValid && specialCharacterValid && numberValid;
  }

  static String? validatePassword(value) {
    if (value!.isEmpty ||
        capitalLetterValid == false ||
        specialCharacterValid == false ||
        numberValid == false) {
      return 'This feild is required, must contain : ';
    }
    return null;
  }
}
