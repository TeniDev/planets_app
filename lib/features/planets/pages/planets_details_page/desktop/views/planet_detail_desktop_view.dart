import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/extensions/extensions.dart';
import 'package:planets_app/core/router/router.dart';
import 'package:planets_app/features/planets/providers/planets_provider.dart';
import 'package:planets_app/gen/assets.gen.dart';

import '../widgets/detail_planet_desktop.dart';

class PlanetDetailDesktopView extends StatelessWidget {
  const PlanetDetailDesktopView({
    super.key,
    required this.idPlanet,
  });

  final String? idPlanet;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, __) {
        if (didPop && !kIsWeb) {
          context.go(RoutesNames.planets);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.go(RoutesNames.planets);
            },
          ),
          title: Consumer(
            builder: (_, ref, __) {
              final loading = ref.watch(planetsProvider.select((state) => state.loadingDetail));
              final planetSelected = ref.watch(planetsProvider.select((state) => state.selectedPlanet));

              return Text(loading ? 'Loading...' : planetSelected?.name ?? '');
            },
          ),
          actions: [
            Consumer(
              builder: (_, ref, __) {
                final planetSelected = ref.watch(planetsProvider.select((state) => state.selectedPlanet));

                return Visibility(
                  visible: planetSelected?.name != null,
                  child: IconButton(
                    icon: Icon(
                      ref.watch(
                        planetsProvider.select(
                          (state) {
                            final favoritePlanets = state.favoritePlanets;
                            final idPlanet = state.selectedPlanet?.name;

                            if (favoritePlanets == null || idPlanet == null) {
                              return Icons.favorite_border;
                            }

                            return favoritePlanets.contains(idPlanet) ? Icons.favorite : Icons.favorite_border;
                          },
                        ),
                      ),
                    ),
                    iconSize: 48,
                    onPressed: () {
                      ref.read(planetsProvider.notifier).setFavoritePlanet(idPlanet!);
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            FadeInUp(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.images.background.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.75),
              ),
            ),
            Consumer(
              builder: (_, ref, __) {
                final loading = ref.watch(planetsProvider.select((state) => state.loadingDetail));
                final planetSelected = ref.watch(planetsProvider.select((state) => state.selectedPlanet));

                if (planetSelected != null && planetSelected.name != idPlanet) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref.read(planetsProvider.notifier).resetSelectedPlanet();
                  });

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }

                if (planetSelected == null) {
                  if (loading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(planetsProvider.notifier).getPlanetDetail(idPlanet);
                    });

                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }

                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'No planet found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.go(RoutesNames.planets);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: Text(
                            context.locale.home_welcome_button,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return DetailPlanetDesktop(
                  planetSelected: planetSelected,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
