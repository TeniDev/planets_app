import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/constants/constants.dart';
import '../gen/l10n.dart';

part 'session_provider.g.dart';
part 'session_provider.freezed.dart';

/// State model for the session provider
@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    required Locale locale,
    required bool isDarkMode,
  }) = _SessionState;
}

/// Provider for the session state
@riverpod
class Session extends _$Session {
  @override
  SessionState build() {
    final localeBox = Hive.box(LocalStorageConstants.sessionBox).get(
      LocalStorageConstants.localeKey,
    );

    final sessionBox = Hive.box(LocalStorageConstants.sessionBox).get(
      LocalStorageConstants.darkModeKey,
    );

    final String defaultLocale = localeBox ?? (kIsWeb ? 'es' : Platform.localeName);
    final bool defaultDarkTheme = sessionBox ?? false;

    return SessionState(
      locale: Locale(defaultLocale.split('_')[0]),
      isDarkMode: defaultDarkTheme,
    );
  }

  changeLocale(Locale locale) async {
    final sessionBox = Hive.box(LocalStorageConstants.sessionBox);
    await sessionBox.put(LocalStorageConstants.localeKey, locale.languageCode);
    state = state.copyWith(
      locale: IntlTranslations.delegate.supportedLocales.contains(locale) ? locale : const Locale('es'),
    );
  }

  changeTheme(bool isDarkMode) async {
    final sessionBox = Hive.box(LocalStorageConstants.sessionBox);
    await sessionBox.put(LocalStorageConstants.darkModeKey, isDarkMode);
    state = state.copyWith(isDarkMode: isDarkMode);
  }
}
