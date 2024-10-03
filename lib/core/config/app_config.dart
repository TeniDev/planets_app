import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';

Future<void> initConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Hive.initFlutter();
  await _openBoxesLocalStorage();
}

Future<void> _openBoxesLocalStorage() async {
  await Hive.openBox(LocalStorageConstants.sessionBox);
  await Hive.openBox(LocalStorageConstants.planetsBox);
}
