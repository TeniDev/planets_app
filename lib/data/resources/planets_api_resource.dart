import 'dart:convert';
import 'package:either_dart/either.dart';

import '../../helpers/helpers.dart';
import '../exceptions/exceptions.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class PlanetsApiResource implements PlanetsRepository {
  PlanetsApiResource({
    required HttpHelper httpHelper,
  }) : _httpHelper = httpHelper;

  final HttpHelper _httpHelper;

  @override
  Future<Either<ApiException, List<PlanetModel>>> getAllPlanets() async {
    try {
      final response = await _httpHelper.get(
        '/planets',
      );

      if (response.statusCode == 200) {
        final planetsResponse = jsonDecode(response.body)['data'] as List;

        List<PlanetModel> planetsList = [];

        for (final planet in planetsResponse) {
          planetsList.add(PlanetModel.fromJson(
            planet as Map<String, dynamic>,
          ));
        }

        return Right(planetsList);
      } else {
        return Left(
          ApiException(
            response.statusCode,
            jsonDecode(response.body)['status_message'] ?? 'Unknown error',
          ),
        );
      }
    } catch (e) {
      return Left(ApiException(500, 'Internal Server Error - $e'));
    }
  }
}
