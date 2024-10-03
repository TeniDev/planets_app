import 'package:flutter/material.dart';

import '../../gen/l10n.dart';

extension ContextExtensions on BuildContext {
  IntlTranslations get locale => IntlTranslations.of(this);

  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  ThemeData get theme => Theme.of(this);
}
