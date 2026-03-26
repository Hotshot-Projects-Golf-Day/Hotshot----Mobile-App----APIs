enum Environment { local, dev, staging, prod }

class AppConfig {
  static Environment env = Environment.dev;
  static String get baseUrl {
    switch (env) {
      case Environment.local:
        return "http://192.168.1.25:4008";
      case Environment.dev:
        return "https://gench-api.appadvent.in";
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
        return "https://gench-api.appadvent.in";
      case Environment.staging:
        return "https://gench-api.appadvent.in";
      case Environment.prod:
        return "https://gench-api.appadvent.in";
    }
  }
}

class Endpoints {
  static const register = "/api/v1/auth/register";
  static const login = "/api/v1/auth/user-login";
  static const logout = "/api/v1/auth/logout";
  static const verifyOtp = "/api/v1/auth/verify-otp";
  static const resendOtp = "/api/v1/auth/resend-otp";
  static const refreshToken = "/api/v1/auth/refresh";
  static const serviceCategories = "/api/v1/service-categories";
  static const forgotPassword = "/api/v1/auth/forgot-password";
  static const verifyForgotPasswordOtp =
      "/api/v1/auth/verify-forgot-password-otp";
  static const resetPassword = "/api/v1/auth/reset-password";
  static const String formQuestions = '/api/v1/questions';
  static const String submitFormAnswers = '/api/v1/questions/answers';

  // projects list

  static const String projectsList = '/api/v1/projects';

  static const String applyProject = '/api/v1/projects/apply';

  static const String userProjects = "/api/v1/projects/user-projects";

  static const String profile = "/api/v1/auth/profile";
}
