import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/config.dart';

Future<void> main() async {
  await initConfig();

  runApp(
    const ProviderScope(
      child: PlanetsApp(),
    ),
  );
}
