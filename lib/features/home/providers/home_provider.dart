import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';
part 'home_provider.freezed.dart';

/// State model for the session provider
@freezed
class HomeState with _$HomeState {
  const factory HomeState() = _HomeState;
}

/// Provider for the session state
@riverpod
class Home extends _$Home {
  @override
  HomeState build() {
    return const HomeState();
  }
}
