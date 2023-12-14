class AppValid {
  String data;
  AppValid({this.data = ''});

  dynamic isValidAccount(
      {required String em,
      required String pw,
      bool key = false,
      String rePw = ''}) {
    if (!AppValid(data: em).isNotNull && !AppValid(data: pw).isNotNull) {
      return 'Nhap email va password';
    } else if (!AppValid(data: em).isValidEmail) {
      return 'Hay nhap dung dinh dang email';
    } else if (!AppValid(data: pw).isValidPassword) {
      return 'Nhap mat khau lon hon 4 nho hon 10';
    } else if (key) {
      if (pw != rePw) {
        return 'Mat khau nhap lai k trung khop';
      }
    }
    return true;
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+.[a-zA-Z]+");
    return emailRegExp.hasMatch(data);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s* ([A-Za-z]{1,}([.,] |[-]]))+[A-Za-z]+.?\s*$");
    return nameRegExp.hasMatch(data);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^(?=.*?[a-z]).{4,10}$');
    return passwordRegExp.hasMatch(data);
  }

  bool get isNotNull {
    return (data.isNotEmpty || data != '');
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^+30[0-9]{10}$");
    return phoneRegExp.hasMatch(data);
  }
}
