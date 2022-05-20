class Validators {
  static String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  static String nameValidator(value) {
    if (value.length < 3)
      return 'Please enter a valid name';
    else
      return null;
  }

  static String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be minimum 8 characters';
    } else {
      return null;
    }
  }

  static String phoneValidator(String value) {
    if (value.length != 10) {
      return 'Password must be 10 digits';
    } else {
      return null;
    }
  }
}
