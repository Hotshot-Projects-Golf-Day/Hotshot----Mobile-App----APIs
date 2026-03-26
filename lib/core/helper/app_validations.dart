import 'package:country_picker/country_picker.dart';

class Validator {
  final String errorText;
  Validator({required this.errorText});

  String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return errorText.isNotEmpty ? errorText : 'Invalid Email';
    }
    return null;
  }

  String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  String? zip(String? value) {
    if (value == null || value.isEmpty) return 'Zip code cannot be empty';
    String pattern = r"^[0-9]{6}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return errorText.isNotEmpty ? errorText : 'Invalid Zip Code';
    }
    return null;
  }

  String? mobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    }

    // Must be exactly 10 digits, starting with 6-9
    String pattern = r'^[6-9][0-9]{9}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  String? mobileEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    }
    return null;
  }

  String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return errorText.isNotEmpty ? errorText : "Can't be empty";
    }
    return null;
  }

  String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (value != password) return 'Passwords do not match';
    return null;
  }

  String? optional(String? value) {
    return null;
  }

  String? usernameOrEmail(String? value) {
    if (value == null || value.isEmpty) return 'Username/Email cannot be empty';

    String emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp emailRegex = RegExp(emailPattern);
    if (emailRegex.hasMatch(value)) {
      return null;
    }

    String usernamePattern = r'^[a-zA-Z0-9_]+$';
    RegExp usernameRegex = RegExp(usernamePattern);
    if (usernameRegex.hasMatch(value)) {
      return null;
    }

    return errorText.isNotEmpty ? errorText : 'Invalid Username or Email';
  }

  String? emailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or phone number cannot be empty';
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    String phonePattern = r'^\d{10}$';

    RegExp emailRegex = RegExp(emailPattern);
    RegExp phoneRegex = RegExp(phonePattern);

    if (emailRegex.hasMatch(value) || phoneRegex.hasMatch(value)) {
      return null;
    }

    return errorText.isNotEmpty
        ? errorText
        : 'Enter a valid email or phone number';
  }

  String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name cannot be empty';
    }

    if (value.trim().split(RegExp(r'\s+')).length > 20) {
      return 'Full name cannot exceed 20 words';
    }

    String pattern = r'^[a-zA-Z ]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return errorText.isNotEmpty ? errorText : 'Enter a valid full name';
    }

    return null;
  }

  String? dob18Plus(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Date of birth is required";
    }

    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final dob = DateTime(year, month, day);
      final today = DateTime.now();

      int age = today.year - dob.year;

      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }

      if (age < 18) {
        return "You must be at least 18 years old";
      }
    } catch (e) {
      return "Enter a valid date";
    }

    return null;
  }

  String? nickName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nickname cannot be empty';
    }

    if (value.trim().length > 10) {
      return 'Nickname must be at most 10 characters';
    }

    return null;
  }

  String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    }

    String pattern = r'^[a-zA-Z0-9_]{3,20}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return errorText.isNotEmpty
          ? errorText
          : 'Username must be 3-20 characters and can only contain letters, numbers, and underscores';
    }

    return null;
  }

  String? mobileInternational(String? value, Country country) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number cannot be empty';
    }

    value = value.trim();

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers allowed';
    }

    int requiredLength = country.example.length;

    if (value.length < requiredLength) {
      return 'Number is too short for ${country.name} (needs $requiredLength digits)';
    }

    if (value.length > requiredLength) {
      return 'Number is too long for ${country.name} (allowed $requiredLength digits)';
    }

    return null;
  }
}
