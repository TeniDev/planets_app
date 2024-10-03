import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:planets_app/core/constants/constants.dart';
import 'package:planets_app/data/models/models.dart';
import 'package:planets_app/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'planets_provider.g.dart';
part 'planets_provider.freezed.dart';

/// State model for the session provider
@Freezed(makeCollectionsUnmodifiable: false)
class PlanetsState with _$PlanetsState {
  const factory PlanetsState({
    required bool isLoading,
    required bool loadingDetail,
    required List<PlanetModel>? planets,
    List<PlanetModel>? filteredPlanets,
    PlanetModel? selectedPlanet,
    List<String>? favoritePlanets,
  }) = _PlanetsState;
}

/// Provider for the session state
@riverpod
class Planets extends _$Planets {
  @override
  PlanetsState build() {
    final favorites = Hive.box(LocalStorageConstants.planetsBox).get(
      LocalStorageConstants.favoritePlanetsKey,
    );

    final listDecoded = jsonDecode(favorites ?? '[]') as List<dynamic>;

    return PlanetsState(
      isLoading: true,
      loadingDetail: true,
      planets: null,
      filteredPlanets: null,
      selectedPlanet: null,
      favoritePlanets: listDecoded.cast<String>(),
    );
  }

  getAllPlanets() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading large data
    final planets = await ref.read(planetsRepositoryProvider).getAllPlanets();

    planets.fold(
      (failure) {
        // TODO: Poner modal de error
        state = state.copyWith(
          isLoading: false,
          planets: null,
        );
      },
      (planets) {
        state = state.copyWith(
          isLoading: false,
          planets: planets,
        );
      },
    );
  }

  filterPlanets(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredPlanets: null);
      return;
    }

    final filteredPlanets = state.planets?.where((planet) {
      return planet.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    state = state.copyWith(
      filteredPlanets: filteredPlanets,
    );
  }

  getPlanetDetail(String? id) async {
    if (id == null) {
      state = state.copyWith(
        loadingDetail: false,
        selectedPlanet: null,
      );
      return;
    }

    state = state.copyWith(loadingDetail: true);

    // Load all planets if they are not loaded
    if (state.planets == null) {
      await getAllPlanets();
    }

    final planet = state.planets
        ?.firstWhere((planet) => planet.name!.toLowerCase() == id.toLowerCase(), orElse: () => const PlanetModel());

    state = state.copyWith(
      loadingDetail: false,
      selectedPlanet: planet?.name == null ? null : planet,
      filteredPlanets: null,
    );
  }

  resetSelectedPlanet() {
    state = state.copyWith(
      selectedPlanet: null,
      loadingDetail: true,
    );
  }

  setFavoritePlanet(String name) async {
    final plannetsBox = Hive.box(LocalStorageConstants.planetsBox);

    final list = await plannetsBox.get(LocalStorageConstants.favoritePlanetsKey);
    final listDecoded = jsonDecode(list ?? '[]') as List<dynamic>;

    listDecoded.add(name);
    final uniqueList = jsonEncode(listDecoded);

    await plannetsBox.put(LocalStorageConstants.favoritePlanetsKey, uniqueList);

    state = state.copyWith(
      favoritePlanets: listDecoded.cast<String>(),
    );
  }
}
