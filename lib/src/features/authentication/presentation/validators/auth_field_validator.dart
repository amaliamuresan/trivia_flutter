class AuthFieldsValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must have at least 6 characters';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return 'Please enter a name.';
    }

    final nameRegex = RegExp(r'^[a-zA-Z]+$');

    if (!nameRegex.hasMatch(value ?? '')) {
      return 'Name can only contain letters.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
    );

    if (!emailRegex.hasMatch(value ?? '')) {
      return 'Please enter a valid email address.';
    }

    return null;
  }
}
