class ResponseErrorHelper {
  static const String _defaultError = "Có lỗi xảy ra, vui lòng thử lại sau";
  ResponseErrorHelper._();
  static final Map<String, String> _responseUserMessage = {
    "Not Found": "Tài khoản hoặc mật khẩu không chính xác!",
    "Email is exists": "Email đã tồn tại!",
    "Refresh token is invalid": "Phiên đăng nhập đã hết hạn!",
    "Code forgot password is not correct or expired":
        "Mã xác nhận không chính xác",
    "Password is not correct": "Mật khẩu hiện tại không đúng!",
  };

  static String getErrorMessage(dynamic error) {
    String? errorMessage;
    if (error?.message?.response?.data is Map &&
        error.message.response.data.containsKey('message')) {
      errorMessage =
          _responseUserMessage[error.message.response.data['message']];
    }
    return errorMessage ?? _defaultError;
  }
}
