import 'package:either_dart/either.dart';

import '../exceptions/exceptions.dart';
import '../models/models.dart';

abstract class PlanetsRepository {
  Future<Either<ApiException, List<PlanetModel>>> getAllPlanets();
}
