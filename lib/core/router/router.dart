import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/features.dart';

part 'routes_handlers.dart';
part 'routes_names.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RoutesNames.home,
    redirect: (_, state) {
      if (!RoutesNames.toList().contains(state.fullPath)) {
        return RoutesNames.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutesNames.home,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: _homeHandler,
      ),
      GoRoute(
        path: RoutesNames.planets,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: _planetsHandler,
      ),
      GoRoute(
        path: RoutesNames.planetDetail,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: _planetDetailHandler,
      ),
    ],
  );
}
