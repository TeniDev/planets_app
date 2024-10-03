import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:planets_app/core/extensions/extensions.dart';
import 'package:planets_app/data/models/planet_model.dart';

class DetailPlanetDesktop extends StatelessWidget {
  const DetailPlanetDesktop({
    super.key,
    required this.planetSelected,
  });

  final PlanetModel planetSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 24,
          ),
          FadeInDown(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      planetSelected.image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 200,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 50),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      children: [
                        Text(
                          planetSelected.description!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        FadeInUp(
                          child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.locale.details,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      context.locale.distance_from_sun,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      '${planetSelected.orbitalDistanceKm} km',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.locale.atmosphere_composition,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        height: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      '${planetSelected.atmosphereComposition}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      context.locale.moons,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      '${planetSelected.moons ?? 0}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      context.locale.day_duration,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      '${planetSelected.dayLengthEarthDays} ${context.locale.days}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
