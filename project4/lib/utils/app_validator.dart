import 'package:project4/utils/string_utils.dart';

class AppValidator {
  AppValidator._();

  static String? emailValidator(String? value) {
    String? errorMessage = _required(value);
    if (errorMessage != null) return errorMessage;

    errorMessage = _regexEmail(value);
    if (errorMessage != null) return errorMessage;

    return null;
  }

  static String? usernameValidator(
      String? value, int minLength, int maxLength) {
    String? errorMessage = _required(value);
    if (errorMessage != null) return errorMessage;

    errorMessage = _minLength(value, minLength);
    if (errorMessage != null) return errorMessage;

    errorMessage = _maxLength(value, maxLength);
    if (errorMessage != null) return errorMessage;

    return null;
  }

  static String? passwordValidator(String? value) {
    String? errorMessage = _required(value);
    if (errorMessage != null) return errorMessage;

    errorMessage = _regexPassword(value);
    if (errorMessage != null) return errorMessage;

    return null;
  }

  static String? codeValidator(String? value) {
    String? errorMessage = _required(value);
    if (errorMessage != null) return errorMessage;
  }

  static String? rePasswordValidator(String? password, String rePassword) {
    if (passwordValidator(password) != null) return null;

    String? errorMessage = _rePasswordLikePassword(password, rePassword);
    if (errorMessage != null) return errorMessage;

    return null;
  }

  static String? _required(String? value) {
    if (!value.isHasText) {
      return 'Đây là trường bắt buộc!';
    }
    return null;
  }

  static String? _minLength(String? value, int length) {
    if (value != null && value.trim().length < length) {
      return 'Tối thiểu $length ký tự!';
    }
    return null;
  }

  static String? _maxLength(String? value, int length) {
    if (value != null && value.trim().length > length) {
      return 'Tối đa $length ký tự!';
    }
    return null;
  }

  static String? _regexPassword(String? value) {
    final passwordRegExp =
        RegExp(r'^(?=.*[a-zA-Z])(?=.*\d?)(?=.*[!@#$%^&*]?).{8,30}$');

    if (value != null && !passwordRegExp.hasMatch(value)) {
      return 'Mật khẩu từ 8 - 30 ký tự, phải bao gồm số, chữ và ký tự đặc biệt!';
    }
    return null;
  }

  static String? _rePasswordLikePassword(String? password, String? rePassword) {
    if (password != rePassword) {
      return 'Nhập lại mật khẩu không đúng!';
    }
    return null;
  }

  static String? _regexEmail(String? value) {
    final emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (value != null && !emailRegExp.hasMatch(value)) {
      return 'Địa chỉ email không đúng định dạng!';
    }
    return null;
  }
}
