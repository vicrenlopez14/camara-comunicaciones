import 'package:camara_comunicaciones/src/App/view/screens/error_screen.dart';
import 'package:camara_comunicaciones/src/App/view/screens/live_streaming_screen.dart';
import 'package:camara_comunicaciones/src/App/view/screens/welcome_screen.dart';
import 'package:camara_comunicaciones/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      name: Routes.root,
      path: Routes.root,
      pageBuilder: (context, state) =>
          const MaterialPage(child: WelcomeScreen()),
    ),
    GoRoute(
      path: Routes.liveStreaming,
      pageBuilder: (context, state) =>
          const MaterialPage(child: LiveStreamingScreen()),
    ),
    GoRoute(
      path: Routes.errorScreen,
      pageBuilder: (context, state) => const MaterialPage(child: ErrorScreen()),
    ),
  ],
  initialLocation: "/",
);
