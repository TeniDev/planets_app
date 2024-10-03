import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/router/router.dart';
import 'package:planets_app/data/models/models.dart';
import 'package:planets_app/features/planets/providers/planets_provider.dart';

class PlanetMobileCard extends StatelessWidget {
  const PlanetMobileCard({
    super.key,
    required this.planet,
    this.isLast = false,
  });

  final PlanetModel planet;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(planetsProvider.notifier).resetSelectedPlanet();
            });
            context.go(
              RoutesNames.planetDetail.replaceAll(':planet', planet.name ?? ''),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: EdgeInsets.only(
              bottom: isLast ? MediaQuery.of(context).padding.bottom + 16 : 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    planet.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              planet.image!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              loadingBuilder: (_, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: SizedBox(
                                    width: 48,
                                    height: 48,
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
                                  size: 48,
                                );
                              },
                            ),
                          )
                        : const Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                            size: 80,
                          ),
                    const SizedBox(width: 16),
                    Text(
                      planet.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
