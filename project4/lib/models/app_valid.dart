class AppValid {
  String data;
  AppValid({this.data = ''});

  dynamic isValidAccount(
      {required String em,
      required String pw,
      bool key = false,
      String rePw = '',
      String name = ''}) {
    if (!AppValid(data: em).isNotNull || !AppValid(data: pw).isNotNull) {
      return 'Các trường không được để trống';
    } else if (!AppValid(data: em).isValidEmail) {
      return 'Hãy nhập đúng định dạng email';
    } else if (!AppValid(data: pw).isValidPassword) {
      return 'Nhập mật khẩu lớn hơn 4 nhỏ hơn 20';
    } else if (key) {
      if (!AppValid(data: name).isValidName) {
        return 'Hãy nhập tên lớn hơn 5 nhỏ hơn 30';
      } else if (pw != rePw) {
        return 'Mật khẩu nhập lại không trùng khớp';
      }
    }
    return true;
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegExp.hasMatch(data);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'.{0,255}$');
    return nameRegExp.hasMatch(data);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*[a-zA-Z])(?=.*\d?)(?=.*[!@#\$%^&*]?).{4,20}$');

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
