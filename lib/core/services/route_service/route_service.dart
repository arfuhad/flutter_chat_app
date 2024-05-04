import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/core.dart';
import 'package:flutter_chat_app/features/auth/auth.dart';
import 'package:flutter_chat_app/features/chat/chat.dart';
import 'package:flutter_chat_app/features/dashboard/dashboard.dart';
import 'package:flutter_chat_app/features/splash/splash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

final GoRouter approuter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        EasyLoading.instance
          ..userInteractions = false
          ..dismissOnTap = false;
        return const SplashView();
      },
      redirect: (BuildContext context, GoRouterState state) async {
        var firebaseAuth = injector<FirebaseAuthService>();
        var value = firebaseAuth.getAuth.currentUser;
        if (value != null) {
          log("firebase auth: current user: $value");
          return '/dashboard';
        } else {
          log("firebase auth: current user: not available");
          // return '/';
          return '/sign-in';
        }
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        String? url = state.extra as String?;

        // return DashboardView(url: url);
        return DashboardView();
      },
    ),
    GoRoute(
      path: '/sign-in',
      builder: (BuildContext context, GoRouterState state) {
        return SignInView();
      },
    ),
    GoRoute(
        path: '/sign-up',
        builder: (BuildContext context, GoRouterState state) {
          return SignUpView();
        }),
    GoRoute(
        path: '/chat',
        builder: (BuildContext context, GoRouterState state) {
          return const ChatView();
        })
  ],
);
