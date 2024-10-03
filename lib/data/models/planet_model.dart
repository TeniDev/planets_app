import 'package:freezed_annotation/freezed_annotation.dart';

part 'planet_model.freezed.dart';
part 'planet_model.g.dart';

@freezed
class PlanetModel with _$PlanetModel {
  const factory PlanetModel({
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "orbital_distance_km") int? orbitalDistanceKm,
    @JsonKey(name: "equatorial_radius_km") int? equatorialRadiusKm,
    @JsonKey(name: "volume_km3", fromJson: _volumeFromJson) String? volumeKm3,
    @JsonKey(name: "mass_kg") String? massKg,
    @JsonKey(name: "density_g_cm3") double? densityGCm3,
    @JsonKey(name: "surface_gravity_m_s2") double? surfaceGravityMS2,
    @JsonKey(name: "escape_velocity_kmh") int? escapeVelocityKmh,
    @JsonKey(name: "day_length_earth_days") double? dayLengthEarthDays,
    @JsonKey(name: "year_length_earth_days") double? yearLengthEarthDays,
    @JsonKey(name: "orbital_speed_kmh") int? orbitalSpeedKmh,
    @JsonKey(name: "atmosphere_composition") String? atmosphereComposition,
    @JsonKey(name: "moons") int? moons,
    @JsonKey(name: "image") String? image,
    @JsonKey(name: "description") String? description,
  }) = _PlanetModel;

  factory PlanetModel.fromJson(Map<String, dynamic> json) => _$PlanetModelFromJson(json);
}

String _volumeFromJson(dynamic value) {
  if (value is int) {
    return value.toString();
  }

  return value;
}
