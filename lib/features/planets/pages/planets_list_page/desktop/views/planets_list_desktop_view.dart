import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/widgets/widgets.dart';
import 'package:planets_app/features/planets/providers/planets_provider.dart';
import 'package:planets_app/gen/assets.gen.dart';

import '../widgets/planet_desktop_card.dart';
import '../widgets/search_planets_desktop_field.dart';

class PlanetsListDesktopView extends StatelessWidget {
  const PlanetsListDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Consumer(
          builder: (_, ref, __) {
            final loading = ref.watch(planetsProvider.select((state) => state.isLoading));
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                loading ? 'Loading...' : 'Explore Planets',
                style: const TextStyle(
                  fontSize: 36,
                ),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          FadeInLeft(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Assets.images.background.path,
                    ),
                    fit: BoxFit.fitHeight,
                    opacity: .6),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(1),
                ],
                stops: const [0.1, .35, .6],
              ),
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              final loading = ref.watch(planetsProvider.select((state) => state.isLoading));
              final planets = ref.watch(planetsProvider.select((state) => state.planets));
              final filteredPlanets = ref.watch(planetsProvider.select((state) => state.filteredPlanets));

              if (planets == null) {
                if (loading) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref.read(planetsProvider.notifier).getAllPlanets();
                  });

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                }

                return const Center(
                  child: Text(
                    'No planets found',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 120),
                  const SearchPlanetsDesktopField(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: filteredPlanets != null && filteredPlanets.isEmpty
                        ? const Center(
                            child: Text(
                              'No planets found' '\nTry another search',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ResponsiveWidget(
                            child: (size, responsiveSizes) {
                              return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: size.width >= responsiveSizes.desktopMedium ? 3 : 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: (1 / (size.width >= responsiveSizes.desktopMedium ? .25 : .3)),
                                ),
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                shrinkWrap: true,
                                itemCount: filteredPlanets != null && filteredPlanets.isNotEmpty
                                    ? filteredPlanets.length
                                    : planets.length,
                                itemBuilder: (_, index) {
                                  final planetsList =
                                      filteredPlanets != null && filteredPlanets.isNotEmpty ? filteredPlanets : planets;
                                  final planet = planetsList[index];

                                  return PlanetDesktopCard(
                                    planet: planet,
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
