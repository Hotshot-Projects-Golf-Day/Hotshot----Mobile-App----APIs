import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:upd8s/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:upd8s/features/auth/presentation/screens/legal_content_screen.dart';
import 'package:upd8s/features/auth/presentation/screens/login_screen.dart';
import 'package:upd8s/features/auth/presentation/screens/otp_verify_screen.dart';
import 'package:upd8s/features/auth/presentation/screens/singup_screen.dart';
import 'package:upd8s/features/home/presentation/screens/home_screen.dart';
import 'package:upd8s/features/post/presentation/screens/create_post_screen.dart';
import 'package:upd8s/features/profile/presentation/screen/profile_screen.dart';
import 'package:upd8s/features/settings/cubit/account_cubit.dart';
import 'package:upd8s/features/settings/presentation/screens/setting_screen.dart';
import 'package:upd8s/features/settings/sections/change_password/change_password_screen.dart';
import 'package:upd8s/features/settings/sections/faq/faq_screen.dart';
import 'package:upd8s/features/settings/sections/help_center/help_center_screen.dart';
import 'package:upd8s/features/settings/sections/membership_plans/membership_plans_screen.dart';
import 'package:upd8s/features/settings/sections/policy/policies_screen.dart';
import 'package:upd8s/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:upd8s/features/splash/presentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  splash(path: '/', name: 'splash'),
  login(path: '/login', name: 'login'),
  signup(path: '/signup', name: 'signup'),
  otpVerify(path: '/otp-verify', name: 'otp-verify'),
  home(path: '/home', name: 'home'),
  forgotPassword(path: '/forgot-password', name: 'forgot-password'),
  // Used in auth flow (signup/login) — static hardcoded content
  terms(path: '/terms', name: 'terms'),
  privacy(path: '/privacy', name: 'privacy'),
  profile(path: '/profile', name: 'profile'),
  setting(path: '/setting', name: 'setting'),
  changePassword(path: '/changePassword', name: 'changePassword'),
  helpCenter(path: '/helpCenter', name: 'helpCenter'),
  faq(path: '/faq', name: 'faq'),
  membership(path: '/membership', name: 'membership'),
  // Used in settings — API-driven content, inside AccountCubit shell
  policies(path: '/policies', name: 'policies'),
  createPost(path: '/createPost', name: 'createPost');

  final String path;
  final String name;

  const AppRoute({required this.path, required this.name});
}

/// A shell route that provides a single [AccountCubit] instance
/// to all account-related screens (settings, change password, help, faq, membership, policies).
final _accountShellKey = GlobalKey<NavigatorState>();

// ── Legal shell key ──────────────────────────────────────────────────────────
final _legalShellKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoute.splash.path,
  debugLogDiagnostics: kDebugMode,
  routes: [
    // ─── Auth / public routes ────────────────────────────────────────────────
    AppGoRoute(
      info: AppRoute.splash,
      builder: (context, state) => BlocProvider(
        create: (_) => SplashCubit()..checkAppStatus(),
        child: const SplashScreen(),
      ),
    ),
    AppGoRoute(
      info: AppRoute.login,
      pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
    ),
    AppGoRoute(
      info: AppRoute.forgotPassword,
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    AppGoRoute(
      info: AppRoute.signup,
      pageBuilder: (context, state) =>
          const MaterialPage(child: SignupScreen()),
    ),
    AppGoRoute(
      info: AppRoute.otpVerify,
      pageBuilder: (context, state) {
        final email = state.extra as String? ?? '';
        return MaterialPage(child: OtpVerifyScreen(email: email));
      },
    ),

    GoRoute(
      name: AppRoute.profile.name,
      path: '/profile',
      builder: (context, state) {
        final isOwnProfile =
            state.uri.queryParameters['isOwnProfile'] == 'true';
        return ProfileScreen(isOwnProfile: isOwnProfile);
      },
    ),
    AppGoRoute(
      info: AppRoute.home,
      pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
    ),
    AppGoRoute(
      info: AppRoute.createPost,
      pageBuilder: (context, state) => MaterialPage(child: CreatePostScreen()),
    ),

    // ─── Legal shell — provides AuthCubit to privacy & terms routes ──────── //
    ShellRoute(
      navigatorKey: _legalShellKey,
      builder: (context, state, child) {
        return BlocProvider(create: (_) => AuthCubit(), child: child);
      },
      routes: [
        AppGoRoute(
          info: AppRoute.privacy,
          pageBuilder: (context, state) =>
              const MaterialPage(child: LegalContentScreen()),
        ),
        AppGoRoute(
          info: AppRoute.terms,
          pageBuilder: (context, state) =>
              const MaterialPage(child: LegalContentScreen()),
        ),
      ],
    ),

    // ─── Account shell — provides AccountCubit ───────────────────────────────
    ShellRoute(
      navigatorKey: _accountShellKey,
      builder: (context, state, child) {
        return BlocProvider(create: (_) => AccountCubit(), child: child);
      },
      routes: [
        AppGoRoute(
          info: AppRoute.setting,
          pageBuilder: (context, state) => MaterialPage(child: SettingScreen()),
        ),
        AppGoRoute(
          info: AppRoute.changePassword,
          pageBuilder: (context, state) =>
              MaterialPage(child: ChangePasswordScreen()),
        ),
        AppGoRoute(
          info: AppRoute.helpCenter,
          pageBuilder: (context, state) =>
              MaterialPage(child: HelpCenterScreen()),
        ),
        AppGoRoute(
          info: AppRoute.faq,
          pageBuilder: (context, state) => MaterialPage(child: FaqScreen()),
        ),
        AppGoRoute(
          info: AppRoute.membership,
          pageBuilder: (context, state) =>
              MaterialPage(child: MembershipPlanScreen()),
        ),
        AppGoRoute(
          info: AppRoute.policies,
          pageBuilder: (context, state) =>
              MaterialPage(child: PoliciesScreen()),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      const Scaffold(body: Center(child: Text("Page Not Found"))),
);

class AppGoRoute extends GoRoute {
  AppGoRoute({
    required AppRoute info,
    super.builder,
    super.pageBuilder,
    super.routes = const [],
  }) : super(path: info.path, name: info.name);
}
