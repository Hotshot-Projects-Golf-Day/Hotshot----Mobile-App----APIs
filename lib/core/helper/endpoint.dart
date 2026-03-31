enum Environment { local, dev, staging, prod }

class AppConfig {
  static Environment env = Environment.dev;
  static String get baseUrl {
    switch (env) {
      case Environment.local:
        return "http://192.168.1.25:4008/api/v1";
      case Environment.dev:
        return "http://82.112.237.18:4008/api/v1";
      case Environment.staging:
        return "https://gench-api.appadvent.in";
      case Environment.prod:
        return "https://gench-api.appadvent.in";
    }
  }

  static String get socketUrl {
    switch (env) {
      case Environment.local:
        return "192.168.1.17";
      case Environment.dev:
        return "http://82.112.237.18:4008/api/v1";
      case Environment.staging:
        return "https://gench-api.appadvent.in";
      case Environment.prod:
        return "https://gench-api.appadvent.in";
    }
  }
}

class Endpoints {
  static const String baseUrl = "http://82.112.237.18:4008/api/v1";

  // Auth
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String refreshToken = "/auth/refresh-token";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendVerificationOtp = "/auth/resend-reset-otp";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resendResetOtp = "/auth/resend-reset-otp";
  static const String verifyForgotPasswordOtp = "/auth/verify-reset-otp";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";

  static const String helpCenter = "/help-center";
  static const String faqs = "/content/faqs";
  static const String policies = "/content/policies";

    static const String createPost = "/content/policies";
}
