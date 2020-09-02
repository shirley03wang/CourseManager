class InputValidator {
  String userNameValidator(String value) {
    if (value.isEmpty) {
      return "Please enter a name";
    }

    RegExp validUser = new RegExp("^[a-zA-Z]+[ ][a-zA-Z]+\$");
    if (!validUser.hasMatch(value)) {
      return "Name must be in the form [FirstName LastName]";
    }
    return null;
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      return "Please enter an email address";
    }

    if (!value.endsWith("@gmail.com")) {
      return "Only google emails (gmail) are valid";
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.isEmpty) {
      return "Please enter a password";
    } else if (value.length < 6) {
      return "Password must have 6 or more characters";
    } else {
      return null;
    }
  }
}