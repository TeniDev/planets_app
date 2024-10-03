import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositories/repositories.dart';
import '../data/resources/resources.dart';
import 'providers.dart';

part 'injection_providers.g.dart';

@riverpod
PlanetsRepository planetsRepository(PlanetsRepositoryRef ref) {
  return PlanetsApiResource(
    httpHelper: ref.read(planetApiProvider),
  );
}
