class LoginFunction {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email required';
    }
    if (!value.contains("@gmail.com")) {
      return 'Invalid email format. It must be like XX@XX.com';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'required ,Please enter a password';
    }
    if (!isPasswordValid(value)) {
      return 'Password must contain at least one uppercase letter,\n one special character, and one digit.';
    }

    return null;
  }

  static bool isPasswordValid(String password) {
    RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*[0-9]).{8,}$');
    return regex.hasMatch(password);
  }

  // static void handleLogin() {
  //     String email = _emailController.text;
  //     String password = _passwordController.text;

  //     OwnersInfo? currentUser;
  //     for (var user in signUpData) {
  //       if (user.email == email && user.password == password) {
  //         currentUser = user;
  //         break;
  //       }
  //     }

  //     if (currentUser != null) {
  //       // Login successful, navigate to the home page
  //       CurrentUser().signUpCurrent(currentUser.uid);
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomePage(currentUserID: currentUser?.uid),
  //         ),
  //         (route) => false,
  //       );
  //     } else {
  //       // Login failed, show an error message
  //       const snackBar = SnackBar(
  //         content:
  //             Text('Invalid credentials. Please check your email and password.'),
  //       );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
}
